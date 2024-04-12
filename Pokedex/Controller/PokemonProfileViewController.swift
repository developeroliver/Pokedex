//
//  PokemonProfileViewController.swift
//  Pokedex
//
//  Created by olivier geiger on 11/04/2024.
//

import UIKit
import SnapKit

class PokemonProfileViewController: UIViewController {

    private let profileImageView: UIImageView = {
            let imageView = UIImageView(image: UIImage(named: "profile"))
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 150 / 2
            return imageView
        }()
        
        private let nameLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
            label.textAlignment = .center
            label.text = "codewitholiver"
            return label
        }()
        
        private let titleLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
            label.textAlignment = .center
            label.textColor = .secondaryLabel
            label.text = "iOS Developer - UIKit and  SwiftUI"
            return label
        }()
        
        private let descriptionLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 16)
            label.textAlignment = .center
            label.numberOfLines = 0
            label.text = "Découvrez et explorez le monde des Pokémon avec Pokedex Explorer. Recherchez, filtrez et explorez les détails de vos Pokémon préférés en utilisant l'API Pokebuild. Une expérience fluide et immersive, développée en Swift avec UIKit en programmatique."
            label.textColor = .tertiaryLabel
            return label
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .systemBackground
            
            view.addSubview(profileImageView)
            view.addSubview(nameLabel)
            view.addSubview(titleLabel)
            view.addSubview(descriptionLabel)
            
            setupConstraints()
        }
        
        private func setupConstraints() {
            profileImageView.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
                make.width.height.equalTo(150)
            }
            
            nameLabel.snp.makeConstraints { make in
                make.top.equalTo(profileImageView.snp.bottom).offset(20)
                make.left.right.equalToSuperview().inset(20)
                make.height.equalTo(30)
            }
            
            titleLabel.snp.makeConstraints { make in
                make.top.equalTo(nameLabel.snp.bottom).offset(10)
                make.left.right.equalToSuperview().inset(20)
                make.height.equalTo(24)
            }
            
            descriptionLabel.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(10)
                make.left.right.equalToSuperview().inset(20)
                make.bottom.lessThanOrEqualToSuperview().inset(20)
            }
        }


}
