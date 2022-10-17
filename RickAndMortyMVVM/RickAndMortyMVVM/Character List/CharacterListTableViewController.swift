//
//  CharacterListTableViewController.swift
//  RickAndMortyMVVM
//
//  Created by Esther on 10/17/22.
//

import UIKit

class CharacterListTableViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var characterSearchBar: UISearchBar!
    // Second part of Dependency Injection. Injecting delegate into initialization of view model. Our view controller now OWNS our view model
    private var viewModel: CharacterListViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = CharacterListViewModel(delegate: self)
        /// Instead of calling fetchCharacters here, extend view controller to adopt searchbardelegate
//        viewModel.fetchCharacters(with: "Morty")
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.characters.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as? CharacterTableViewCell else {return UITableViewCell()}
        let character = viewModel.characters[indexPath.row]
        cell.configureCell(with: character)
        /// pass fully configured cell to be displayed
        return cell
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
} // End of Class

extension CharacterListTableViewController: CharacterListViewModelDelegate {
    func updateViews() {
        tableView.reloadData()
    }
}

extension CharacterListTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.fetchCharacters(with: searchText)
    }
}
