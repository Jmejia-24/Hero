//
//  Failure.swift
//  Hero
//
//  Created by Byron Mejia on 12/23/22.
//

enum Failure: Error {
    case decodingError
    case urlConstructError
    case APIError(Error)
    case statusCode
}
