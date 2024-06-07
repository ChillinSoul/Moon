//
//  ContentView.swift
//  Moon
//
//  Created by Axel Bergiers on 21/04/2024.
//

import SwiftUI

struct ClientsView: View {
    @ObservedObject var clientFetcher = GraphQLClient()
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Search", text: $searchText)
                        .padding(10)
                        .padding(.horizontal, 25)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .overlay(
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 8)
                                if !searchText.isEmpty {
                                    Button(action: {
                                        self.searchText = ""
                                    }) {
                                        Image(systemName: "multiply.circle.fill")
                                            .foregroundColor(.gray)
                                            .padding(.trailing, 8)
                                    }
                                }
                            }
                        )
                        .padding(.horizontal, 20)

                    Spacer()
                    NavigationLink(destination: NewClient()) {
                        Image(systemName: "plus.circle")
                            .font(.title)
                            .padding(.trailing, 20)
                    }
                }
                .padding(.vertical, 10)

                List {
                    ForEach(clientFetcher.clients.filter {
                        self.searchText.isEmpty ? true : $0.name.localizedCaseInsensitiveContains(self.searchText)
                    }) { client in
                        NavigationLink(destination: ClientView(graphQLClient: clientFetcher, client: client)) {
                            ClientListItem(client: client)
                        }
                    }
                }
                .refreshable {
                    clientFetcher.fetchGraphQLData()
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
