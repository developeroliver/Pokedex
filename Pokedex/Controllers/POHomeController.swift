//
//  POHomeController.swift
//  Pokedex
//
//  Created by olivier geiger on 15/03/2024.
//

import UIKit

class POHomeController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponents()
        
    }
    
    
    // MARK: Selectors
    @objc func showSearchBar() {
        print("Show searchbar")
    }
    
    
    // MARK: Helper Functions
    func configureViewComponents() {
        collectionView.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.barTintColor    = .systemPink
        navigationController?.navigationBar.barStyle        = .black
        
        navigationItem.title = "Pokédex"
        navigationItem.rightBarButtonItem                  = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showSearchBar))
        navigationItem.rightBarButtonItem?.tintColor       = .secondaryLabel
    }
}
