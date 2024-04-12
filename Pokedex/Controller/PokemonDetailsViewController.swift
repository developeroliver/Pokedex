//
//  PokemonDetailsViewController.swift
//  Pokedex
//
//  Created by olivier geiger on 11/04/2024.
//

import UIKit
import SnapKit

class PokemonDetailsViewController: UIViewController {
    
    let pokemon: Pokemon
    
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
    
    private let type1ImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let type2ImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        setupPokemonsDetails()
    }
    
    private func layout() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .label
        
        if let url = URL(string: pokemon.apiTypes[0].image) {
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                if let data = data {
                    DispatchQueue.main.async {
                        self?.type1ImageView.image = UIImage(data: data)
                    }
                } else {
                    print("Error downloading image: \(error?.localizedDescription ?? "Unknown error")")
                }
            }.resume()
        }
        
        if pokemon.apiTypes.indices.contains(1) {
            // Accédez à l'élément seulement si l'index est valide
            if let imageUrl = URL(string: pokemon.apiTypes[1].image) {
                URLSession.shared.dataTask(with: imageUrl) { [weak self] data, response, error in
                    if let data = data {
                        DispatchQueue.main.async {
                            self?.type2ImageView.image = UIImage(data: data)
                        }
                    } else {
                        print("Error downloading image: \(error?.localizedDescription ?? "Unknown error")")
                        // Utilisez une image par défaut
                        DispatchQueue.main.async {
                            self?.type2ImageView.image = UIImage(named: "")
                        }
                    }
                }.resume()
            } else {
                // Aucune URL d'image disponible, utilisez une image par défaut
                type2ImageView.image = UIImage(named: "")
            }
        } else {
            // L'index est hors de la plage valide, utilisez une image par défaut
            type2ImageView.image = UIImage(named: "")
        }
        
        
        view.addSubview(pokemonImageView)
        view.addSubview(numberLabel)
        view.addSubview(type1ImageView)
        view.addSubview(type2ImageView)
        
        pokemonImageView.snp.makeConstraints { make in
            make.height.width.equalTo(200)
            make.top.equalToSuperview().offset(100)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        numberLabel.snp.makeConstraints { make in
            make.bottom.equalTo(pokemonImageView.snp.bottom).offset(-50)
            make.leading.equalTo(view.snp.leading).offset(40)
        }
        
        if pokemon.apiTypes.count == 1 {
            type1ImageView.snp.makeConstraints { make in
                make.height.width.equalTo(40)
                make.top.equalTo(pokemonImageView.snp.bottom).offset(10)
                make.centerX.equalToSuperview()
            }
        } else {
            type1ImageView.snp.makeConstraints { make in
                make.height.width.equalTo(40)
                make.top.equalTo(pokemonImageView.snp.bottom).offset(10)
                make.leading.equalTo(view.snp.leading).offset(130)
            }
            type2ImageView.snp.makeConstraints { make in
                make.height.width.equalTo(40)
                make.top.equalTo(pokemonImageView.snp.bottom).offset(10)
                make.trailing.equalTo(view.snp.trailing).offset(-130)
            }
        }
        
        
    }
    
    
    private func setupPokemonsDetails() {
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
