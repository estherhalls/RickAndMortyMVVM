//
//  APIService.swift
//  RickAndMortyMVVM
//
//  Created by Esther on 10/17/22.
//

import UIKit

///Network Service for our Fetch Call
struct APIService {
    // Very generic network call. Could be copy and pasted in any project and it would work
     func perform(_ request: URLRequest, completion: @escaping (Result<Data, ResultError>) -> Void) {
        // Data Task
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                completion(.failure(.requestError(error)))
            }
            if let response = response as? HTTPURLResponse {
                print("Completed with a response of", response.statusCode)
            }
            //Check for Data
            guard let data else {
                completion(.failure(.noData))
                return
            }
            completion(.success(data))
        }.resume()
    }
} // End of Struct
