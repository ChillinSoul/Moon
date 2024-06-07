//
//  ContentView.swift
//  Moon
//
//  Created by Axel Bergiers on 21/04/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack{
                Spacer()
                HStack {
                    NavigationLink(destination: ClientsView().navigationBarBackButtonHidden(true)) {
                        Text("clients")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
