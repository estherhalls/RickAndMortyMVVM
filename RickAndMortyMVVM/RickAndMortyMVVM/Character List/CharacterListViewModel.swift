//
//  CharacterListViewModel.swift
//  RickAndMortyMVVM
//
//  Created by Esther on 10/17/22.
//

import Foundation

protocol CharacterListViewModelDelegate: AnyObject {
    func updateViews()
}
/// started with struct but changed to class because it was giving me "immutable" error in fetchCharacters
class CharacterListViewModel {
    
    var characters: [Character] = []
    weak var delegate: CharacterListViewModelDelegate?
    
    // Dependency Injection from view model to this view controller because this view should not exist without its view model. The act of injecting the dependency into the INITIALIZATION of this object.
    
    init(delegate: CharacterListViewModelDelegate) {
        self.delegate = delegate
    }
    
    func fetchCharacters(with name: String) {
        APIService.fetchCharacters(with: name) { result in
            switch result {
            case .failure(let error):
                print(error.errorDescription)
            case.success(let tld):
                self.characters = tld.results
                /// add to main thread
                DispatchQueue.main.async {
                    /// now tell the delegate to update views and show the character you retrieved
                    self.delegate?.updateViews()
                }
            }
        }
    }
    
} // End of Class
