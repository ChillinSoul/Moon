//
//  ClientView.swift
//  Moon
//
//  Created by Axel Bergiers on 21/04/2024.
//

import SwiftUI

struct ClientView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showAlert = false
    @State private var client: Client
    @ObservedObject var graphQLClient: GraphQLClient
    
    init(graphQLClient: GraphQLClient, client: Client) {
        self.graphQLClient = graphQLClient
        _client = State(initialValue: client)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(client.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    if let firstName = client.firstName, let lastName = client.lastName {
                        Text("\(firstName) \(lastName)")
                            .font(.title2)
                            .foregroundColor(.secondary)
                    }
                }
                Spacer()
                NavigationLink(destination: EditClientView(client: client, onSave: { updatedClient in
                    self.client = updatedClient
                })) {
                    Text("Edit")
                        .padding(10)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                }
            }
            .padding(.bottom, 10)
            
            VStack(alignment: .leading, spacing: 15) {
                if let email = client.email {
                    ContactInfoRow(icon: "envelope", text: email, action: {
                        if let url = URL(string: "mailto:\(email)") {
                            UIApplication.shared.open(url)
                        }
                    })
                }
                if let telephone = client.telephone {
                    ContactInfoRow(icon: "phone", text: telephone, action: {
                        if let url = URL(string: "tel:\(telephone)") {
                            UIApplication.shared.open(url)
                        }
                    })
                }
                if let street = client.street, let zipCode = client.zipCode, let country = client.country {
                    ContactInfoRow(icon: "map", text: "\(street), \(zipCode), \(country)")
                }
                if let comments = client.comments {
                    ContactInfoRow(icon: "text.bubble", text: comments)
                }
                
                Divider()
                
                ContactInfoRow(icon: "dollarsign.circle", text: "\(client.balance.formatted(.number.precision(.fractionLength(2))) + " USD")")
                ContactInfoRow(icon: "shippingbox", text: "\(client.colisage)")
                ContactInfoRow(icon: "scalemass", text: "\(client.poids.formatted(.number.precision(.fractionLength(2))) + " kg")")
            }
            
            Spacer()
            
            Button(action: {
                showAlert = true
            }) {
                Text("Delete")
                    .padding(10)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(5)
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Delete Client"),
                    message: Text("Are you sure you want to delete this client?"),
                    primaryButton: .destructive(Text("Delete")) {
                        graphQLClient.deleteClient(client)
                        presentationMode.wrappedValue.dismiss()
                    },
                    secondaryButton: .cancel()
                )
            }
        }
        .padding()
        .navigationTitle("Client Details")
    }
}

struct ContactInfoRow: View {
    var icon: String
    var text: String
    var action: (() -> Void)? = nil
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 25)
            if let action = action {
                Button(action: action) {
                    Text(text)
                        .font(.body)
                }
            } else {
                Text(text)
                    .font(.body)
            }
            Spacer()
        }
        .padding(.vertical, 5)
    }
}

#Preview {
    NavigationView {
        ClientView(graphQLClient: GraphQLClient(), client: DummyClients[0])
    }
}
