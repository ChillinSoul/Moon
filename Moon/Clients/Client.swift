//
//  Client.swift
//  Moon
//
//  Created by Axel Bergiers on 21/04/2024.
//

import Foundation

class Client: Identifiable, Codable {
    var id: String
    var name: String
    var balance: Float
    var colisage: Int
    var poids: Float

    enum CodingKeys: String, CodingKey {
        case name
        case balance
        case colisage
        case poids
    }

    init(id: String = UUID().uuidString, name: String, balance: Float, colisage: Int, poids: Float) {
        self.id = id
        self.name = name
        self.balance = balance
        self.colisage = colisage
        self.poids = poids
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.balance = try container.decode(Float.self, forKey: .balance)
        self.colisage = try container.decode(Int.self, forKey: .colisage)
        self.poids = try container.decode(Float.self, forKey: .poids)
        self.id = UUID().uuidString // Generate a unique id for each client
    }
}
let DummyClients = [
    Client(name: "John Doe", balance: 1000, colisage: 5, poids: 10.5),
    Client(name: "Jane Doe", balance: 2000, colisage: 10, poids: 20.5),
    Client(name: "Alice Doe", balance: 3000, colisage: 15, poids: 30.5),
    Client(name: "Bob Doe", balance: 4000, colisage: 20, poids: 40.5)
]



