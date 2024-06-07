//
//  NewClient.swift
//  Moon
//
//  Created by Axel Bergiers on 21/04/2024.
//
import SwiftUI

struct NewClient: View {

    @State private var name = ""
    @State private var lastName = ""
    @State private var firstName = ""
    @State private var email = ""
    @State private var telephone = ""
    @State private var street = ""
    @State private var city = ""
    @State private var zipCode = ""
    @State private var country = ""
    @State private var comments = ""

    @ObservedObject var graphQLClient = GraphQLClient()

    var body: some View {
        NavigationView {
            VStack {
                Text("Nouveau Client")
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
                        TextField("Ville", text: $city)
                        TextField("Code Postal", text: $zipCode)
                        TextField("Pays", text: $country)
                    }
                    Section(header: Text("Commentaires")) {
                        TextField("Commentaires", text: $comments)
                    }
                }
                Button(action: {
                    saveClient()
                }) {
                    Text("Enregistrer")
                }
                .padding()
            }
            .navigationBarTitle("Nouveau Client", displayMode: .inline)
        }
    }

    private func saveClient() {
        let newClient = Client(
            id:name,
            name: name,
            firstName: firstName,
            lastName: lastName,
            email: email,
            telephone: telephone,
            street: street,
            zipCode: zipCode,
            country: country,
            comments: comments,
            balance: 0,
            colisage: 0,
            poids: 0
        )

        graphQLClient.addClient(newClient)
    }
}

struct NewClient_Previews: PreviewProvider {
    static var previews: some View {
        NewClient()
    }
}
