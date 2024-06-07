//
//  ClientListItem.swift
//  Moon
//
//  Created by Axel Bergiers on 21/04/2024.
//

import SwiftUI

struct ClientListItem: View {
    var client: Client
    var body: some View {
        
        HStack {
            Avatar(name: client.name)
            VStack(alignment: .leading) {
                Text(client.name)
                    .font(.headline)
                HStack {
                    Image(systemName: "dollarsign.circle")
                    Text("\(client.balance.formatted(.number.precision(.fractionLength(2))))")
                        .font(.subheadline)
                }
            }
            Spacer()
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "shippingbox")
                    Text("\(client.colisage)")
                        .font(.headline)
                }
                HStack {
                    Image(systemName: "scalemass")
                    Text("\(client.poids.formatted(.number.precision(.fractionLength(2))))")
                        .font(.subheadline)
                        
                }
            }
        }
    }
}

#Preview {
    ClientListItem(client: DummyClients[0])
}
