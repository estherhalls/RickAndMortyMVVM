//
//  CharacterTableViewCell.swift
//  RickAndMortyMVVM
//
//  Created by Esther on 10/17/22.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

  // MARK: - Outlets
    @IBOutlet weak var characterImageImageView: ServiceRequestingImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    
    private let apiService = APIService()
    
    /// So images don't flash and jump around when loading while scrolling fast
    override func prepareForReuse() {
        super.prepareForReuse()
        characterImageImageView.image = nil
    }
    
    /// Call this method in the table view controller when building UI of the cell
    func configureCell(with character: Character) {
        characterNameLabel.text = character.name
        /// fetch image from APIService file
        fetchImage(for: character)
        makeRounded()
    }
    
    func makeRounded() {
        characterImageImageView.layer.cornerRadius = characterImageImageView.frame.size.width / 2
        characterImageImageView.clipsToBounds = true
    }
    
    /// Calling from service requesting image view
    func fetchImage(for character: Character) {
        guard let imageURL = URL(string: character.imageString) else {return}
        characterImageImageView.fetchImage(from: imageURL)
    }
    
}// End of Class
