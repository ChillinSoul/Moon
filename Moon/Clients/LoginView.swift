//
//  LoginView.swift
//  Moon
//
//  Created by Axel Bergiers on 07/06/2024.
//

import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    @ObservedObject var graphQLClient: GraphQLClient
    @Binding var isAuthenticated: Bool

    var body: some View {
        NavigationView{
            
            VStack {
                Text("MOON")
                    .font(.custom("Helvetica Neue", size: 80))
                    .padding(.bottom)
                Text("Login")
                    .font(.title)
                    .padding()
                TextField("Username", text: $username)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.bottom, 20)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.bottom, 20)
                
                Button(action: {
                                graphQLClient.login(username: username, password: password) { success, error in
                                    if success {
                                        isAuthenticated = true
                                        UserDefaults.standard.set(Date(), forKey: "lastLoginTimestamp") // Save login timestamp
                                    } else {
                                        errorMessage = error!
                                    }
                                }
                            }) {
                                Text("Login")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .padding()
                
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .padding()
        }.navigationTitle("Login")
    }

    private func login() {
        graphQLClient.login(username: username, password: password) { success, error in
            if success {
                isAuthenticated = true
            } else {
                errorMessage = error ?? "Unknown error"
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(graphQLClient: GraphQLClient(), isAuthenticated: .constant(false))
    }
}
