//
//  PokedexCell.swift
//  Pokedex
//
//  Created by olivier geiger on 15/03/2024.
//

import UIKit

class PokedexCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius    = 10
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
