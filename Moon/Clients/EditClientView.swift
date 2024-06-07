//
//  EditClientView.swift
//  Moon
//
//  Created by Axel Bergiers on 07/06/2024.
//

import SwiftUI

struct EditClientView: View {
    @State private var name: String
    @State private var lastName: String
    @State private var firstName: String
    @State private var email: String
    @State private var telephone: String
    @State private var street: String
    @State private var zipCode: String
    @State private var country: String
    @State private var comments: String

    @ObservedObject var graphQLClient = GraphQLClient()
    @Environment(\.presentationMode) var presentationMode

    var client: Client
    var onSave: (Client) -> Void

    init(client: Client, onSave: @escaping (Client) -> Void) {
        self.client = client
        self.onSave = onSave
        _name = State(initialValue: client.name)
        _lastName = State(initialValue: client.lastName ?? "")
        _firstName = State(initialValue: client.firstName ?? "")
        _email = State(initialValue: client.email ?? "")
        _telephone = State(initialValue: client.telephone ?? "")
        _street = State(initialValue: client.street ?? "")
        _zipCode = State(initialValue: client.zipCode ?? "")
        _country = State(initialValue: client.country ?? "")
        _comments = State(initialValue: client.comments ?? "")
    }

    var body: some View {
        NavigationView {
            VStack {
                Text("Modifier Client")
                    .font(.title)
                    .padding()
                Form {
                    Section(header: Text("Informations")) {
                        TextField("Désignation", text: $name)
                        TextField("Nom", text: $lastName)
                        TextField("Prénom", text: $firstName)
                        TextField("Email", text: $email)
                        TextField("Téléphone", text: $telephone)
                    }
                    Section(header: Text("Adresse")) {
                        TextField("Rue", text: $street)
                        TextField("Code Postal", text: $zipCode)
                        TextField("Pays", text: $country)
                    }
                    Section(header: Text("Commentaires")) {
                        TextField("Commentaires", text: $comments)
                    }
                }
                Button(action: {
                    updateClient()
                }) {
                    Text("Enregistrer")
                }
                .padding()
            }
            .navigationBarTitle("Modifier Client", displayMode: .inline)
        }
    }

    private func updateClient() {
        let updatedClient = Client(
            id: client.id,
            name: name,
            firstName: firstName,
            lastName: lastName,
            email: email,
            telephone: telephone,
            street: street,
            zipCode: zipCode,
            country: country,
            comments: comments,
            balance: client.balance,
            colisage: client.colisage,
            poids: client.poids
        )

        graphQLClient.updateClient(updatedClient)
        onSave(updatedClient)
        presentationMode.wrappedValue.dismiss()
    }
}

struct EditClientView_Previews: PreviewProvider {
    static var previews: some View {
        EditClientView(client: Client(
            id: "1",
            name: "Test Name",
            firstName: "Test First Name",
            lastName: "Test Last Name",
            email: "test@example.com",
            telephone: "123456789",
            street: "Test Street",
            zipCode: "12345",
            country: "Test Country",
            comments: "Test Comments",
            balance: 0,
            colisage: 0,
            poids: 0
        )) { _ in }
    }
}
