//
//  PokedexController.swift
//  Pokedex
//
//  Created by olivier geiger on 15/03/2024.
//

import UIKit

private let reuseID = "PokedexCell"

class PokedexController: UICollectionViewController {
    
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
        
        collectionView.register(PokedexCell.self, forCellWithReuseIdentifier: reuseID)
    }
}


extension PokedexController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseID, for: indexPath) as! PokedexCell
        cell.backgroundColor = .systemPink
        return cell
    }
}


extension PokedexController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 32, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (view.frame.width - 28) / 2
        return CGSize(width: width, height: width)
    }
}
