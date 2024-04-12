//
//  Pokemon.swift
//  Pokedex
//
//  Created by olivier geiger on 11/04/2024.
//

import UIKit

struct Pokemon: Decodable {
    let id: Int
    let pokedexId: Int
    let name: String
    let image: String
    let apiTypes: [PokemonType]
    let stats: Stats
    
    enum CodingKeys: String, CodingKey {
        case id
        case pokedexId
        case name
        case image = "image"
        case apiTypes 
        case stats
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        pokedexId = try container.decode(Int.self, forKey: .pokedexId)
        name = try container.decode(String.self, forKey: .name)
        image = try container.decode(String.self, forKey: .image)
        apiTypes = try container.decode([PokemonType].self, forKey: .apiTypes)
        stats = try container.decode(Stats.self, forKey: .stats)
    }
}

struct PokemonType: Decodable {
    let name: String
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case image
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        image = try container.decode(String.self, forKey: .image)
    }
}

struct Stats: Decodable {
    let HP: Int
    let attack: Int
    let defense: Int
    let specialAttack: Int
    let specialDefense: Int
    let speed: Int
    
    enum CodingKeys: String, CodingKey {
        case HP
        case attack
        case defense
        case specialAttack = "special_attack"
        case specialDefense = "special_defense"
        case speed
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        HP = try container.decode(Int.self, forKey: .HP)
        attack = try container.decode(Int.self, forKey: .attack)
        defense = try container.decode(Int.self, forKey: .defense)
        specialAttack = try container.decode(Int.self, forKey: .specialAttack)
        specialDefense = try container.decode(Int.self, forKey: .specialDefense)
        speed = try container.decode(Int.self, forKey: .speed)
    }
}
