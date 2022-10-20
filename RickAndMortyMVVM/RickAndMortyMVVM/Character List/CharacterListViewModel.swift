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
    private let service = CharacterSearchService()
    
    // Dependency Injection from view model to this view controller because this view should not exist without its view model. The act of injecting the dependency into the INITIALIZATION of this object.
    init(delegate: CharacterListViewModelDelegate) {
        self.delegate = delegate
    }
    
    func fetchCharacters(with name: String) {
        service.fetchCharacterList(for: .name(name)) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error.errorDescription)
            case .success(let tld):
                self?.characters = tld.results
                DispatchQueue.main.async {
                    self?.delegate?.updateViews()
                }
            }
        }
    }
    
    func presentDefaultData() {
        
    }
    
} // End of Class
