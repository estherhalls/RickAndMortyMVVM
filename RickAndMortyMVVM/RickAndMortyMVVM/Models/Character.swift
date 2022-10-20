//
//  Character.swift
//  RickAndMortyMVVM
//
//  Created by Esther on 10/17/22.
//

import Foundation

/// For every nested dictionary, we need a new struct
struct TopLevelDictionary: Decodable {
    let info: Info
    let results: [Character]
} // End of Struct

struct Info: Decodable {
    private enum CodingKeys: String, CodingKey {
        case nextURL = "next"
    }
    let nextURL: String
    
} // End of Struct

/// Character is the dictionary within results array
struct Character: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
        case species
        case gender
        case origin
        case location
        case imageString = "image"
    }
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let origin: OriginDictionary
    let location: LocationDictionary
    let imageString: String
    
} // End of Struct

struct OriginDictionary: Decodable {
    let name: String
    
} // End of Struct

struct LocationDictionary: Decodable {
    let name: String
    
} // End of Struct
