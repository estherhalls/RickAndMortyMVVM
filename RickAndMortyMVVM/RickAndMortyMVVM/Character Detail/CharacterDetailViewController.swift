//
//  CharacterDetailViewController.swift
//  RickAndMortyMVVM
//
//  Created by Esther on 10/19/22.
//

import UIKit
class CharacterDetailViewController: UIViewController {
    @IBOutlet weak var characterIDLabel: UILabel!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterStatusLabel: UILabel!
    @IBOutlet weak var characterLocationLabel: UILabel!
    @IBOutlet weak var characterSpeciesLabel: UILabel!
    @IBOutlet weak var characterOriginLabel: UILabel!
    @IBOutlet weak var characterGenderLabel: UILabel!
    @IBOutlet weak var characterImageImageView: UIImageView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configure(with character: Character, and image: UIImage?) {
        /// Solve race condition from segue competing with view in memory
        loadViewIfNeeded()
        
        // Doing if let because if it can't find an image, I still want it to run the rest of the code to retrieve data for other labels
        if let image{
            characterImageImageView.image = image
        }
        characterIDLabel.text = "ID no. \(character.id)"
        characterNameLabel.text = character.name
        characterStatusLabel.text = " Status: \(character.status)"
        characterLocationLabel.text = "Current Location: \(character.location.name)"
        characterSpeciesLabel.text = character.species
        characterOriginLabel.text = "Origin: \(character.origin.name)"
        characterGenderLabel.text = character.gender
    }
    
} // End of Class
