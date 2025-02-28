//
//  Stock.swift
//  Ahead
//
//  Created by Henry MacLane on 10/4/24.
//

import Foundation

struct Stock: Identifiable, Decodable {
    let id = UUID()
    let symbol: String
    let name: String
    let logoURL: String?
    let description: String?
    let price: Double?
    let lastUpdated: String?
    
    enum CodingKeys: String, CodingKey {
        case symbol
        case name // This should match the 'name' field from the API
        case logoURL
        case description = "about" // Make sure this matches the API field correctly
        case price = "close" // Match the 'close' field for price
        case lastUpdated = "timestamp" // Match the 'timestamp' field for lastUpdated
    }
}
