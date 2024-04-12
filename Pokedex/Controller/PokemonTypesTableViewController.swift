//
//  PokemonTypesTableViewController.swift
//  Pokedex
//
//  Created by olivier geiger on 11/04/2024.
//

import UIKit

class PokemonTypesTableViewController: UITableViewController {
    
    private var types: [Types] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Types de Pokémon"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        PokedexManager.shared.getAllTypes { [weak self] types in
            guard let types = types else {
                return
            }
            self?.types = types
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return types.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let type = types[indexPath.row]
        cell.textLabel?.text = type.name
        
        if let url = URL(string: type.image) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    return
                }
                
                DispatchQueue.main.async {
                    cell.imageView?.image = UIImage(data: data)
                    cell.setNeedsLayout()
                }
            }.resume()
        }
        
        cell.imageView?.contentMode = .scaleAspectFit
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
