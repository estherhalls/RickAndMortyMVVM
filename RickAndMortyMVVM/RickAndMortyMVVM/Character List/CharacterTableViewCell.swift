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
    
    // Call this method in the table view controller when building UI of the cell
    func configureCell(with character: Character) {
        characterNameLabel.text = character.name
        // fetch image from APIService file
        fetchImage(for: character)
    }
    func fetchImage(for character: Character) {
        APIService.fetchImage(for: character.imageString) { result in
            /// Switch because result required result or error
            switch result {
            case .failure(let error):
                print(error)
            case .success(let image):
                /// self because we are within a closure. Also put it on main thread.
                DispatchQueue.main.async {
                    self.characterImageImageView.image = image
                }
            }
        }
    }
}
