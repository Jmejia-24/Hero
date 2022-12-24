//
//  Response.swift
//  Hero
//
//  Created by Byron Mejia on 12/23/22.
//

import Foundation

struct Response: Codable {
    let philosophers: [Philosopher]
    
    private enum CodingKeys: String, CodingKey {
        case philosophers = "filosofos"
    }
}
