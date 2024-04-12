//
//  PokemonFavoriteViewController.swift
//  Pokedex
//
//  Created by olivier geiger on 11/04/2024.
//

import UIKit

import UIKit

class PokemonSearchViewController: UIViewController {
    
    private var filteredPokemons: [Pokemon] = []
    private var allPokemons: [Pokemon] = [] // Ajout de la propriété pour stocker tous les Pokémon
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PokemonCollectionViewCell.self, forCellWithReuseIdentifier: PokemonCollectionViewCell.reuseIdentifier)
        return collectionView
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Rechercher un Pokémon"
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Rechercher un Pokémon"
        searchBar.delegate = self
        
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Charger tous les Pokémon lors du chargement initial de la vue
        PokedexManager.shared.getAllPokemon { [weak self] pokemons in
            guard let pokemons = pokemons else {
                return
            }
            self?.allPokemons = pokemons
        }
        
        let closeButton = UIBarButtonItem(title: "Fermer", style: .plain, target: self, action: #selector(closeKeyboard))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let toolbar = UIToolbar()
        toolbar.items = [flexibleSpace, closeButton]
        toolbar.sizeToFit()
        
        // Assurez-vous que la barre d'outils s'affiche sur le clavier
        searchBar.inputAccessoryView = toolbar
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            
            // Fermer le clavier en démissionnant le premier répondant
            searchBar.resignFirstResponder()
        }
    
    @objc func closeKeyboard() {
        searchBar.resignFirstResponder() // Fermer le clavier
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Définir la position et la taille de la barre de recherche
        searchBar.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.frame.width, height: 50)
        
        // Définir la position et la taille de la collectionView sous la barre de recherche
        collectionView.frame = CGRect(x: 0, y: view.safeAreaInsets.top + searchBar.frame.height, width: view.frame.width, height: view.frame.height - (view.safeAreaInsets.top + searchBar.frame.height))
    }
}

extension PokemonSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            filteredPokemons = []
            collectionView.reloadData()
            return
        }
        
        // Filtrer les Pokémon à partir de tous les Pokémon chargés
        let filteredPokemons = allPokemons.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        self.filteredPokemons = filteredPokemons
        collectionView.reloadData()
    }
    
    
}

extension PokemonSearchViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredPokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.reuseIdentifier, for: indexPath) as! PokemonCollectionViewCell
        let pokemon = filteredPokemons[indexPath.item]
        cell.configure(with: pokemon)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 30) / 2 // On divise la largeur de la collection view par 2 avec un espace de 10 points entre les cellules
        return CGSize(width: width, height: width) // On retourne une taille carrée
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pokemon = filteredPokemons[indexPath.row]
        let navigation = PokemonDetailsViewController(pokemon: pokemon)
        navigationController?.pushViewController(navigation, animated: true)
    }
}



