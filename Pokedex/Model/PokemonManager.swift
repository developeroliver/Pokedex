//
//  PokemonManager.swift
//  Pokedex
//
//  Created by olivier geiger on 11/04/2024.
//

import UIKit

class PokedexManager {
    static let shared = PokedexManager()
    
    private var pokemons: [Pokemon] = []
    private var types: [Types] = []
    
    private init() {}
    
    func getAllPokemon(completion: @escaping ([Pokemon]?) -> Void) {
        guard let url = URL(string: "https://pokebuildapi.fr/api/v1/pokemon") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                let pokemons = try JSONDecoder().decode([Pokemon].self, from: data)
                completion(pokemons)
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
    
    func getPokemonByName(byName: String,completion: @escaping ([Pokemon]?) -> Void) {
        guard let url = URL(string: "https://pokebuildapi.fr/api/v1/pokemon/\(byName)") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                let pokemons = try JSONDecoder().decode([Pokemon].self, from: data)
                completion(pokemons)
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }

    func getAllTypes(completion: @escaping ([Types]?) -> Void) {
            guard let url = URL(string: "https://pokebuildapi.fr/api/v1/types") else {
                completion(nil)
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    completion(nil)
                    return
                }
                
                do {
                    let types = try JSONDecoder().decode([Types].self, from: data)
                    completion(types)
                    print(types)
                } catch {
                    print("Error decoding JSON: \(error)")
                    completion(nil)
                }
            }.resume()
        }
}
