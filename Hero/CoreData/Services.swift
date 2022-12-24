//
//  Services.swift
//  Hero
//
//  Created by Byron Mejia on 12/24/22.
//

import CoreData

protocol Serviceable {
    func fetch(completion: @escaping (Result<[NSManagedObject], Failure>) -> ())
    func create(philosopher: Philosopher, completion: @escaping (Result<Bool, Failure>) -> ())
    func saveDataOf(philosophers: [Philosopher])
}

final class Services {
    private let storage: Storage
    
    required init(storage: Storage) {
        self.storage = storage
    }
}

extension Services: Serviceable {
    
    func fetch(completion: @escaping (Result<[NSManagedObject], Failure>) -> ()) {
        storage.fetch { result in
            switch result {
            case .success(let todos):
                if let todos = todos {
                    completion(.success(todos))
                } else {
                    completion(.failure(.statusCode))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func create(philosopher: Philosopher, completion: @escaping (Result<Bool, Failure>) -> ()) {
        storage.create(object: philosopher) { result in
            switch result {
            case .success:
                completion(.success(true))
            case .failure:
                completion(.failure(.statusCode))
            }
        }
    }
    
    func saveDataOf(philosophers: [Philosopher]) {
        storage.saveDataOf(philosophers: philosophers)
    }
}
