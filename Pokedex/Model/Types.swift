//
//  Types.swift
//  Pokedex
//
//  Created by olivier geiger on 11/04/2024.
//

import UIKit

struct Types: Decodable {
    let id: Int
    let name: String
    let image: String
    let englishName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image
        case englishName = "englishName"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        image = try container.decode(String.self, forKey: .image)
        englishName = try container.decode(String.self, forKey: .englishName)
    }
}
