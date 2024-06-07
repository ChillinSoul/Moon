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
    var firstName: String
    var lastName: String
    var email: String
    var telephone: String
    var street: String
    var zipCode: String
    var country: String
    var comments: String
    var balance: Float
    var colisage: Int
    var poids: Float

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case firstName
        case lastName
        case email
        case telephone
        case street
        case zipCode
        case country
        case comments
        case balance
        case colisage
        case poids
    }

    init(id: String = UUID().uuidString, name: String, firstName: String, lastName: String, email: String, telephone: String, street: String, zipCode: String, country: String, comments: String, balance: Float, colisage: Int, poids: Float) {
        self.id = id
        self.name = name
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.telephone = telephone
        self.street = street
        self.zipCode = zipCode
        self.country = country
        self.comments = comments
        self.balance = balance
        self.colisage = colisage
        self.poids = poids
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.lastName = try container.decode(String.self, forKey: .lastName)
        self.email = try container.decode(String.self, forKey: .email)
        self.telephone = try container.decode(String.self, forKey: .telephone)
        self.street = try container.decode(String.self, forKey: .street)
        self.zipCode = try container.decode(String.self, forKey: .zipCode)
        self.country = try container.decode(String.self, forKey: .country)
        self.comments = try container.decode(String.self, forKey: .comments)
        self.balance = try container.decode(Float.self, forKey: .balance)
        self.colisage = try container.decode(Int.self, forKey: .colisage)
        self.poids = try container.decode(Float.self, forKey: .poids)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(email, forKey: .email)
        try container.encode(telephone, forKey: .telephone)
        try container.encode(street, forKey: .street)
        try container.encode(zipCode, forKey: .zipCode)
        try container.encode(country, forKey: .country)
        try container.encode(comments, forKey: .comments)
        try container.encode(balance, forKey: .balance)
        try container.encode(colisage, forKey: .colisage)
        try container.encode(poids, forKey: .poids)
    }
}

let DummyClients = [
    Client(name: "John Doe", firstName: "John", lastName: "Doe", email: "john@example.com", telephone: "123456789", street: "123 Elm St",zipCode: "10", country: "USA", comments: "Regular customer", balance: 1000, colisage: 5, poids: 10.5),
    Client(name: "Jane Doe", firstName: "Jane", lastName: "Doe", email: "jane@example.com", telephone: "987654321", street: "456 Oak St",zipCode: "10", country: "USA", comments: "VIP customer", balance: 2000, colisage: 10, poids: 20.5),
    Client(name: "Alice Doe", firstName: "Alice", lastName: "Doe", email: "alice@example.com", telephone: "555555555", street: "789 Pine St",zipCode: "10", country: "USA", comments: "New customer", balance: 3000, colisage: 15, poids: 30.5),
    Client(name: "Bob Doe", firstName: "Bob", lastName: "Doe", email: "bob@example.com", telephone: "111222333", street: "101 Maple St",zipCode: "10", country: "USA", comments: "Frequent buyer", balance: 4000, colisage: 20, poids: 40.5)
]



