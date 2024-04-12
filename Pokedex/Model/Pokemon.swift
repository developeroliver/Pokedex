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
    
    enum CodingKeys: String, CodingKey {
        case id
        case pokedexId
        case name
        case image = "image"
        case apiTypes 
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        pokedexId = try container.decode(Int.self, forKey: .pokedexId)
        name = try container.decode(String.self, forKey: .name)
        image = try container.decode(String.self, forKey: .image)
        apiTypes = try container.decode([PokemonType].self, forKey: .apiTypes)
    }
}

struct PokemonType: Codable {
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
