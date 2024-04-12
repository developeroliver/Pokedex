//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by olivier geiger on 11/04/2024.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    // MARK: - PROPERTIES
    var pokemons: [Pokemon] = []
    
    // MARK: - LIFECYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        setupGetAllPokemon()
    }
    
    private func layout() {
        title = "Pokedex"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(PokemonTableViewCell.self, forCellReuseIdentifier: "PokemonCell")
    }
    
    private func setupGetAllPokemon() {
        PokedexManager.shared.getAllPokemon { [weak self] pokemons in
            guard let self = self, let pokemons = pokemons else { return }
            self.pokemons = pokemons
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as! PokemonTableViewCell
        let pokemon = pokemons[indexPath.row]
        cell.configure(with: pokemon)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let backButton = UIBarButtonItem()
        backButton.title = pokemons[indexPath.row].name
            navigationItem.backBarButtonItem = backButton
        
        let pokemon = pokemons[indexPath.row]
        let navigation = PokemonDetailsViewController(pokemon: pokemon)
        navigationController?.pushViewController(navigation, animated: true)
        
    }
}
