//
//  GraphQL.swift
//  Moon
//
//  Created by Axel Bergiers on 20/05/2024.
//

import Foundation
import Combine

//MARK: replace this IP with the current IP
let url = URL(string: "http://172.17.32.73:4000/graphql")!

class GraphQLClient: ObservableObject {
    @Published var clients: [Client] = []
    private var token: String?

    func login(username: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        let query = """
        query Query($username: String, $password: String) {
          login(username: $username, password: $password) {
            ID
            LAST_TOKEN
            USERNAME
          }
        }
        """
        
        let variables: [String: Any] = [
            "username": username,
            "password": password
        ]
        
        performGraphQLRequest(query: query, variables: variables) { [weak self] result in
            switch result {
            case .success(let data):
                if let errors = data["errors"] as? [[String: Any]], let errorMessage = errors.first?["message"] as? String {
                    completion(false, errorMessage)
                } else if let loginData = data["data"] as? [String: Any],
                          let login = loginData["login"] as? [String: Any],
                          let id = login["ID"] as? String,
                          let token = login["LAST_TOKEN"] as? String,
                          let username = login["USERNAME"] as? String {
                    self?.token = token
                    completion(true, nil)
                } else {
                    print("Result: \(result)")
                    completion(false, "Invalid response data")
                }
            case .failure(let error):
                completion(false, error.localizedDescription)
            }
        }
    }


    
    func fetchGraphQLData() {
        print("fetching clients")
        let query = """
        query Clients {
            clients {
                name
                firstName
                lastName
                email
                telephone
                street
                zipCode
                country
                comments
                balance
                colisage
                poids
            }
        }
        """
        
        performGraphQLRequest(query: query) { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    if let dataDict = data["data"] as? [String: Any],
                       let clientsArray = dataDict["clients"] as? [[String: Any]] {
                        let jsonData = try JSONSerialization.data(withJSONObject: clientsArray, options: [])
                        let clients = try JSONDecoder().decode([Client].self, from: jsonData)
                        DispatchQueue.main.async {
                            self?.clients = clients
                        }
                    } else {
                        print("Invalid response format: 'clients' key not found")
                    }
                } catch {
                    print("Failed to parse clients: \(error)")
                }
            case .failure(let error):
                print("Error fetching clients: \(error.localizedDescription)")
            }
        }
    }
    
    func addClient(_ client: Client) {
        let mutation = """
        mutation Mutation($client: ClientInput!) {
            addClient(client: $client) {
                name
                firstName
                lastName
                email
                telephone
                street
                zipCode
                country
                comments
                balance
                colisage
                poids
            }
        }
        """
        
        let variables: [String: Any] = [
            "client": [
                "name": client.name,
                "balance": client.balance,
                "colisage": client.colisage,
                "poids": client.poids,
                "firstName": client.firstName,
                "lastName": client.lastName,
                "email": client.email,
                "telephone": client.telephone,
                "street": client.street,
                "zipCode": client.zipCode,
                "country": client.country,
                "comments": client.comments
            ]
        ]
        
        performGraphQLRequest(query: mutation, variables: variables) { [weak self] result in
            switch result {
            case .success(let data):
                if let dataDict = data["data"] as? [String: Any], // Ensure accessing the "data" field
                   dataDict["addClient"] != nil {
                    self?.fetchGraphQLData()
                } else {
                    print("Invalid response format after adding client")
                }
            case .failure(let error):
                print("Error adding client: \(error.localizedDescription)")
            }
        }
    }
    
    func updateClient(_ client: Client) {
        let mutation = """
        mutation Mutation($editClientId: ID, $client: ClientInput) {
          editClient(id: $editClientId, client: $client) {
            name
            firstName
            lastName
            email
            telephone
            street
            zipCode
            country
            comments
            balance
            colisage
            poids
          }
        }
        """
        
        let variables: [String: Any] = [
            "editClientId": client.name,
            "client": [
                "name": client.name,
                "balance": client.balance,
                "colisage": client.colisage,
                "poids": client.poids,
                "firstName": client.firstName,
                "lastName": client.lastName,
                "email": client.email,
                "telephone": client.telephone,
                "street": client.street,
                "zipCode": client.zipCode,
                "country": client.country,
                "comments": client.comments
            ]
        ]
        
        performGraphQLRequest(query: mutation, variables: variables) { [weak self] result in
            switch result {
            case .success(let data):
                if let dataDict = data["data"] as? [String: Any],
                   dataDict["editClient"] != nil {
                    self?.fetchGraphQLData()
                } else {
                    print("Invalid response format after updating client")
                }
            case .failure(let error):
                print("Error updating client: \(error.localizedDescription)")
            }
        }
    }
    
    
    func deleteClient(_ client: Client) {
        let mutation = """
        mutation Mutation($deleteClientId: ID) {
          deleteClient(id: $deleteClientId) {
            name
          }
        }
        """
        
        let variables: [String: Any] = ["deleteClientId": client.name]
        
        performGraphQLRequest(query: mutation, variables: variables) { [weak self] result in
            switch result {
            case .success(let data):
                if let dataDict = data["data"] as? [String: Any], 
                   dataDict["deleteClient"] != nil {
                    self?.fetchGraphQLData()
                } else {
                    print("Invalid response format after deleting client")
                }
            case .failure(let error):
                print("Error deleting client: \(error.localizedDescription)")
            }
        }
    }
    
    
    private func performGraphQLRequest(query: String, variables: [String: Any]? = nil, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var body: [String: Any] = ["query": query]
        if let variables = variables {
            body["variables"] = variables
        }
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                return
            }
            
            do {
                if let responseJSON = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    completion(.success(responseJSON))
                } else {
                    completion(.failure(NSError(domain: "Invalid response format", code: -1, userInfo: nil)))
                }
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
