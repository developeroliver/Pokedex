//
//  PokemonDetailsViewController.swift
//  Pokedex
//
//  Created by olivier geiger on 11/04/2024.
//

import UIKit
import SnapKit

class PokemonDetailsViewController: UIViewController {
    
    // MARK: - PROPERTIES
    let pokemon: Pokemon
    
    // MARK: - UI DECLARATION
    private let pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let nameLabel = PokemonLabel(text: "", fontSize: 22)
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
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
    
    private let hpLabel = PokemonLabel(text: "HP:", fontSize: 22)
    private let attackLabel = PokemonLabel(text: "Attack:", fontSize: 22)
    private let defenseLabel = PokemonLabel(text: "Defense:", fontSize: 22)
    private let specialAttackLabel = PokemonLabel(text: "Special Attack:", fontSize: 22)
    private let specialDefenseLabel = PokemonLabel(text: "Special defense:", fontSize: 22)
    private let speedLabel = PokemonLabel(text: "Speed:", fontSize: 22)
    
    // MARK: - UISTACKVIEW
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            hpLabel,
            attackLabel,
            defenseLabel,
            specialAttackLabel,
            specialDefenseLabel,
            speedLabel,
        ])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    // MARK: - LIFECYCLE METHODS
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
        animateImage()
        animateLabels()
    }
}

// MARK: - FUNCTIONS
extension PokemonDetailsViewController {
    
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
        view.addSubview(nameLabel)
        view.addSubview(numberLabel)
        view.addSubview(type1ImageView)
        view.addSubview(type2ImageView)
        view.addSubview(stackView)
        
        pokemonImageView.snp.makeConstraints { make in
            make.height.width.equalTo(200)
            make.top.equalToSuperview().offset(130)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(pokemonImageView.snp.bottom).offset(20)
        }
        
        numberLabel.snp.makeConstraints { make in
            make.bottom.equalTo(pokemonImageView.snp.bottom).offset(-50)
            make.leading.equalTo(view.snp.leading).offset(40)
        }
        
        if pokemon.apiTypes.count == 1 {
            type1ImageView.snp.makeConstraints { make in
                make.height.width.equalTo(40)
                make.top.equalTo(nameLabel.snp.bottom).offset(40)
                make.centerX.equalToSuperview()
            }
        } else {
            type1ImageView.snp.makeConstraints { make in
                make.height.width.equalTo(40)
                make.top.equalTo(nameLabel.snp.bottom).offset(40)
                make.leading.equalTo(view.snp.leading).offset(130)
            }
            type2ImageView.snp.makeConstraints { make in
                make.height.width.equalTo(40)
                make.top.equalTo(nameLabel.snp.bottom).offset(40)
                make.trailing.equalTo(view.snp.trailing).offset(-130)
            }
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(type1ImageView.snp.bottom).offset(80)
            make.leading.equalToSuperview().offset(30)
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
        nameLabel.text = pokemon.name
        
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
    
    private func animateLabels() {
        hpLabel.text = "HP: \(pokemon.stats.HP)"
        attackLabel.text = "Attack: \(pokemon.stats.attack)"
        defenseLabel.text = "Defense: \(pokemon.stats.defense)"
        specialAttackLabel.text = "Special Attack: \(pokemon.stats.specialAttack)"
        specialDefenseLabel.text = "Special Defense: \(pokemon.stats.specialDefense)"
        speedLabel.text = "Speed: \(pokemon.stats.speed)"
        
        hpLabel.transform = CGAffineTransform(translationX: -100, y: 50)
        attackLabel.transform = CGAffineTransform(translationX: -200, y: 150)
        defenseLabel.transform = CGAffineTransform(translationX: -300, y:
                                                    250)
        specialAttackLabel.transform = CGAffineTransform(translationX: -400, y: 350)
        specialDefenseLabel.transform = CGAffineTransform(translationX: -500, y: 450)
        speedLabel.transform = CGAffineTransform(translationX: -600, y: 550)
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseInOut], animations: {
            self.hpLabel.transform = .identity
            self.attackLabel.transform = .identity
            self.defenseLabel.transform = .identity
            self.specialAttackLabel.transform = .identity
            self.specialDefenseLabel.transform = .identity
            self.speedLabel.transform = .identity
        }, completion: nil)
    }

    private func animateImage() {
        pokemonImageView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseInOut], animations: {
            self.pokemonImageView.transform = .identity
        }, completion: nil)
    }

}
