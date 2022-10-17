//
//  APIService.swift
//  RickAndMortyMVVM
//
//  Created by Esther on 10/17/22.
//

import Foundation

///Network Service for our Fetch Call

struct APIService {
    static let baseURLString = "https://rickandmortyapi.com/api"
    // URL Components:
    private static let kCharacterComponent = "character"
    // URL Keys:
    private static let kNameKey = "name"
    
    
    /// hits network, which means it reaches the API and will be put on a background thread and needs a completion handler with an escaping closure
    static func fetchCharacters(with searchTerm: String, completion: @escaping (Result<TopLevelDictionary, ResultError>) -> Void) {
        // Step 1: Get URL from baseURL
        guard let baseURL = URL(string: baseURLString) else {
            completion(.failure(.badURL))
            return
        }
        let characterURL = baseURL.appendingPathComponent(kCharacterComponent)
        
        // URLComponents Struct allows Query items to be added
        var urlComponents = URLComponents(url: characterURL, resolvingAgainstBaseURL: true)
        
        // Add URL Query Items
        let nameFilter = URLQueryItem(name: kNameKey, value: searchTerm)
        urlComponents?.queryItems = [nameFilter]
        
        guard let finalURL = urlComponents?.url else {
            completion(.failure(.badURL))
            return
        }
        // Data Task
        URLSession.shared.dataTask(with: finalURL) { dTaskData, _, error in
            if let error {
                completion(.failure(.requestError(error)))
            }
            // Check for Data
            guard let data = dTaskData else {
                completion(.failure(.noData))
                return
            }
            do {
                /// do not need catch because try is optional
                guard let topLevelDictionary = try? JSONDecoder().decode(TopLevelDictionary.self, from: data) else {
                    completion(.failure(.couldNotUnwrap))
                    return
                }
                completion(.success(topLevelDictionary))
            }
            completion(.failure(.errorDecoding))
            
        }.resume()
    }
} // End of Struct
