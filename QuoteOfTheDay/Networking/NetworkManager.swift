//
//  NetworkManager.swift
//  QuoteOfTheDay
//
//  Created by Juvin R on 11/28/24.
//

import SwiftUI

struct NetworkManager {
    
    func fetch<T: Codable>(from urlString: String) async throws -> T {
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let result = try JSONDecoder().decode(T.self, from: data)
        
        return result
    }
}
