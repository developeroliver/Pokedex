//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by olivier geiger on 11/04/2024.
//

import UIKit
import SnapKit

class PokemonTableViewCell: UITableViewCell {
    
    // MARK: - UI DECLARATION
    private let pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    // MARK: - UISTACKVIEW
    private lazy var stackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [
            nameLabel,
            numberLabel,
       ])
        stackView.axis = .vertical
//        stackView.spacing = 5
        stackView.alignment = .trailing
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    // MARK: - LIFECYCLE METHODS
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layout()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with pokemon: Pokemon) {
        nameLabel.text = pokemon.name
        
        if let url = URL(string: pokemon.image) {
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                if let data = data {
                    DispatchQueue.main.async {
                        self?.pokemonImageView.image = UIImage(data: data)
                    }
                } else {
                    print("Error downloading image: \(error?.localizedDescription ?? "Unknown error")")
                }
            }.resume()
        }
        
        switch pokemon.id {
        case 0...9:
            return numberLabel.text = "#00\(pokemon.id)"
        case 10...99:
            return numberLabel.text = "#0\(pokemon.id)"
        case 100...999:
            return numberLabel.text = "#\(pokemon.id)"
        default:
            return numberLabel.text = "#\(pokemon.id)"
        }
    }
}

// MARK: - FUNCTIONS
extension PokemonTableViewCell {
    
    private func layout() {
        addSubview(pokemonImageView)
        addSubview(stackView)
        
        pokemonImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(30)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(100)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.bottom.equalToSuperview().offset(-30)
            make.trailing.equalTo(snp.trailing).offset(-40)
        }
    }
}
