//
//  RMEndpoint.swift
//  RickAndMortyMVVM
//
//  Created by Esther on 10/18/22.
//

import Foundation
/// Abstract the creation of our URLs to allow us to use any enpoint we want
/// Use enum because it allows cases
enum RMFilterEndpoint {
    case .name
    case .gender
    case .species
    case .status
}
