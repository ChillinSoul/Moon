//
//  ClientView.swift
//  Moon
//
//  Created by Axel Bergiers on 21/04/2024.
//

import SwiftUI

struct ClientView: View {
    var client: Client
    var body: some View {
        VStack {
           
            Text(client.name)
                .font(.headline)
            Spacer()
            HStack {
                Image(systemName: "dollarsign.circle")
                Text("\(client.balance.formatted(.number.precision(.fractionLength(2))) + " USD")")
                    .font(.subheadline)
            }
            HStack {
                Image(systemName: "shippingbox")
                Text("\(client.colisage)")
                    .font(.headline)
            }
            HStack {
                Image(systemName: "scalemass")
                Text("\(client.poids.formatted(.number.precision(.fractionLength(2))) + " kg")")
                    .font(.subheadline)
            }
        }
    }
}

#Preview {
    ClientView(client: DummyClients[0])
}
