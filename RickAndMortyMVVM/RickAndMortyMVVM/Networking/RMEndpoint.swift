//
//  RMEndpoint.swift
//  RickAndMortyMVVM
//
//  Created by Esther on 10/18/22.
//

import Foundation

/// Abstract the creation of our URLs to allow us to use any enpoint we want using one inclusive/interchangable function rather than a full function for each endpoint
/// Use enum because it allows cases
enum RMFilterEndpoint {
    
    case name(String)
    case status(String)
    case species(String)
    case gender(String)
    
    var endpoint: String {
        switch self {
        case .name:
            return "name"
        case .status:
            return "status"
        case .species:
            return "species"
        case .gender:
            return "gender"
        }
    }
    
    // Computed property (open scope)
    var fullURL: URL? {
        guard var baseURL = URL(string: "https://rickandmortyapi.com/api/") else {return nil}
        let characterURL = baseURL.appendingPathComponent("character")
        
        switch self {
        case .name(let searchTerm), .status(let searchTerm), .species(let searchTerm), .gender(let searchTerm):
            
            guard var components = URLComponents(url: characterURL, resolvingAgainstBaseURL: true) else
            { return nil }
            let filterQueryItem = URLQueryItem(name: endpoint, value: searchTerm)
            components.queryItems = [filterQueryItem]
            
            return components.url
        }
    }
}
