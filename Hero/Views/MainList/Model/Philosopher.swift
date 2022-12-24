//
//  Philosopher.swift
//  Hero
//
//  Created by Byron Mejia on 12/23/22.
//

import Foundation

struct Philosopher: Codable, Hashable {
    var id: String
    var name: String
    var period: String
    var country: String
    var sentence: String
    var image: String?
    var imageDat: Data?
    var isNew: Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name = "nombre"
        case period = "periodo"
        case country = "pais"
        case sentence = "frase"
        case image = "img"
    }
}
