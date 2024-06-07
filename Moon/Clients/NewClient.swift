//
//  NewClient.swift
//  Moon
//
//  Created by Axel Bergiers on 21/04/2024.
//

import SwiftUI

struct NewClient: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Nouveau Client")
                    .font(.title)
                    .padding()
                Form {
                    Section(header: Text("Informations")) {
                        TextField("Nom", text: .constant(""))
                        TextField("Prénom", text: .constant(""))
                        TextField("Email", text: .constant(""))
                        TextField("Téléphone", text: .constant(""))
                    }
                    Section(header: Text("Adresse")) {
                        TextField("Rue", text: .constant(""))
                        TextField("Ville", text: .constant(""))
                        TextField("Code Postal", text: .constant(""))
                        TextField("Pays", text: .constant(""))
                    }
                    Section(header: Text("Commentaires")) {
                        TextField("Commentaires", text: .constant(""))
                    }
                }
                Button(action: {
                    print("Save")
                }) {
                    Text("Enregistrer")
                }
            }
        }
    }
}

#Preview {
    NewClient()
}
