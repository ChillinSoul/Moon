//
//  ContentView.swift
//  Moon
//
//  Created by Axel Bergiers on 21/04/2024.
//
import SwiftUI

struct ClientsView: View {
    @ObservedObject var clientFetcher = GraphQLClient()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        clientFetcher.fetchGraphQLData()
                    }) {
                        Image(systemName: "arrow.clockwise")
                            .font(.title)
                            .padding(.leading, 20)
                    }
                    
                    NavigationLink(destination: NewClient()) {
                        Image(systemName: "plus.circle")
                            .font(.title)
                            .padding(.trailing, 20)
                    }
                }
                List(clientFetcher.clients) { client in
                    NavigationLink(destination: ClientView(client: client)) {
                        ClientListItem(client: client)
                    }
                }
            }
            .onAppear {
                clientFetcher.fetchGraphQLData()
            }
        }
    }
}

#Preview {
    ClientsView()
}


