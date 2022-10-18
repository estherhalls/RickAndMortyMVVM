//
//  CharacterSearchService.swift
//  RickAndMortyMVVM
//
//  Created by Esther on 10/18/22.
//

import Foundation
struct CharacterSearchService {
    
    // Give directed access to APIService without making it static and available to all files on APIService file
    private let apiService = APIService()
    func fetchCharacterList(for endpoint: ,completionHandler: @escaping (Result<TopLevelDictionary, ResultError>) -> Void) {
        aPIService.perform(<#T##request: URLRequest##URLRequest#>) { result in
            switch result {
            case.failure(let error):
                completionHandler(.failure(.requestError(error)))
            case.success(let data):
                do {
                    let tld = JSONDecoder().decode(TopLevelDictionary.self, from: data)
                    completionHandler(.success(tld))
                } catch {
                    completionHandler(.failure(.errorDecoding))
                }
            }
        }
    }
}
