//
//  PokemonProfileViewController.swift
//  Pokedex
//
//  Created by olivier geiger on 11/04/2024.
//

import UIKit

class PokemonProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Profile"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

}
