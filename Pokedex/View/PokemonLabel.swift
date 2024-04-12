//
//  PokemonStatsLabel.swift
//  Pokedex
//
//  Created by olivier geiger on 11/04/2024.
//

import UIKit

class PokemonLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(text: String, fontSize: CGFloat) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        configure()
    }
    
    private func configure() {
        text = text
        textColor = .label
        translatesAutoresizingMaskIntoConstraints = false
    }
}


