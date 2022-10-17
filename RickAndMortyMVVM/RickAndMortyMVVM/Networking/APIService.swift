//
//  APIService.swift
//  RickAndMortyMVVM
//
//  Created by Esther on 10/17/22.
//

import UIKit

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
    ///These are both network calls, so there is redundancy. The only thing different is the URL passing in
    //Import UIKit rather than foundation at top of this file in order to get image
    static func fetchImage(for image: String, completion: @escaping (Result<UIImage, ResultError>) -> Void) {
        guard let imageURL = URL(string: image) else { return }
        URLSession.shared.dataTask(with: imageURL) { dTaskData, _, error in
            if let error {
                completion(.failure(.requestError(error)))
            }
            // Check for data
            guard let data = dTaskData else {
                completion(.failure(.noData))
                return
            }
            guard let image = UIImage(data: data) else {
                completion(.failure(.errorDecoding))
                return
            }
            completion(.success(image))
            
        }.resume()
        
    }
    
} // End of Struct
