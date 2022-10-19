//
//  CharacterTableViewCell.swift
//  RickAndMortyMVVM
//
//  Created by Esther on 10/17/22.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

  // MARK: - Outlets
    
    @IBOutlet weak var characterImageImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    
    private let apiService = APIService()
    
    // Call this method in the table view controller when building UI of the cell
    func configureCell(with character: Character) {
        characterNameLabel.text = character.name
        // fetch image from APIService file
        fetchImage(for: character)
        makeRounded()
    }
    
    func makeRounded() {
        characterImageImageView.layer.cornerRadius = characterImageImageView.frame.size.width / 2
        characterImageImageView.clipsToBounds = true
    }
    
    func fetchImage(for character: Character) {
        guard let imageURL = URL(string: character.imageString) else {return}
        let request = URLRequest(url: imageURL)
        apiService.perform(request) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error.errorDescription)
            case .success(let data):
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self?.characterImageImageView.image = image
                }
            }
        }
    }
}
