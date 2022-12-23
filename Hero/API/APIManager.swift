//
//  APIManager.swift
//  Hero
//
//  Created by Byron Mejia on 12/23/22.
//

import UIKit
import Combine

protocol MainListStore {
    func getPhilosophers() -> Future<Response, Failure>
}

final class APIManager {
    let baseURL = "https://e2281b7c-a157-469c-9d52-da0bfdd12337.mock.pstmn.io/getPhilosophers"
}

extension APIManager: MainListStore {
    func getPhilosophers() -> Future<Response, Failure> {
        return Future { [unowned self] promise in
            guard let url = URL(string: baseURL) else {
                promise(.failure(.urlConstructError))
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data, case .none = error else { promise(.failure(.urlConstructError)); return }
                do {
                    let decoder = JSONDecoder()
                    let allPokemonBase = try decoder.decode(Response.self, from: data)
                    promise(.success(allPokemonBase))
                } catch {
                    promise(.failure(.APIError(error)))
                }
            }
            task.resume()
        }
    }
}
