//
//  MainTabBarController.swift
//  Pokedex
//
//  Created by olivier geiger on 11/04/2024.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    // MARK: - LIFECYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemOrange
        viewControllers                 = [createHomeNC(), createSearchNC(), createTypesNC(), createProfileNC()]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - FUNCTIONS
    func createHomeNC() -> UINavigationController {
        let homeVC        = PokemonTableViewController()
        homeVC.tabBarItem = UITabBarItem(title: "Accueil", image: UIImage(systemName: "tag.fill"), tag: 0)
        
        return UINavigationController(rootViewController: homeVC)
    }
    
    
    func createSearchNC() -> UINavigationController {
        let SearchVC         = PokemonSearchViewController()
        SearchVC.tabBarItem  = UITabBarItem(title: "Rechercher", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        
        return UINavigationController(rootViewController: SearchVC)
    }
    
    func createTypesNC() -> UINavigationController {
        let typesVC         = PokemonTypesTableViewController()
        typesVC.tabBarItem  = UITabBarItem(title: "Types", image: UIImage(systemName: "poweroutlet.type.a"), tag: 2)
        
        return UINavigationController(rootViewController: typesVC)
    }
    
    func createProfileNC() -> UINavigationController {
        let profileVC         = PokemonProfileViewController()
        profileVC.tabBarItem  = UITabBarItem(title: "Profil", image: UIImage(systemName: "person.fill"), tag: 3)
        
        return UINavigationController(rootViewController: profileVC)
    }
}
