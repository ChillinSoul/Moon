//
//  GraphQL.swift
//  Moon
//
//  Created by Axel Bergiers on 20/05/2024.
//

import Foundation
import Combine

class GraphQLClient: ObservableObject {
    @Published var clients: [Client] = []
    
    func fetchGraphQLData() {
        let url = URL(string: "http://192.168.129.22:4000/graphql")! // Replace with your computer's local IP address
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let query = """
        query Clients {
            clients {
                name
                balance
                colisage
                poids
            }
        }
        """
        
        let jsonQuery = ["query": query]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: jsonQuery, options: [])
        } catch {
            print("Failed to serialize query: \(error)")
            return
        }
        
        print("Request: \(request)")
        if let body = request.httpBody, let bodyString = String(data: body, encoding: .utf8) {
            print("Request Body: \(bodyString)")
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Response Status Code: \(httpResponse.statusCode)")
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                if let responseJSON = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("Response JSON: \(responseJSON)")
                    if let data = responseJSON["data"] as? [String: Any],
                       let clientsArray = data["clients"] as? [[String: Any]] {
                        print("Clients Array: \(clientsArray)")
                        let jsonData = try JSONSerialization.data(withJSONObject: clientsArray, options: [])
                        let clients = try JSONDecoder().decode([Client].self, from: jsonData)
                        DispatchQueue.main.async {
                            self.clients = clients
                            print("Parsed Clients: \(clients)")
                        }
                    } else {
                        print("Failed to find 'data' or 'clients' in response JSON")
                    }
                }
            } catch {
                print("Failed to parse JSON: \(error)")
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Response String: \(responseString)")
                }
            }
        }
        
        task.resume()
    }
}
