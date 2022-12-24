//
//  AddNewPhilosopherViewModel.swift
//  Hero
//
//  Created by Byron Mejia on 12/23/22.
//

import Foundation

protocol AddNewPhilosopherViewModelRepresentable {
    func save(name: String, period: String, country: String, sentence: String, imageDat: Data)
}

final class AddNewPhilosopherViewModel<R: AppRouter> {
    var router: R?
    let id: Int
    
    var services: Serviceable
    
    init(model: Int, services: Serviceable) {
        self.id = model
        self.services = services
    }
}

extension AddNewPhilosopherViewModel: AddNewPhilosopherViewModelRepresentable {
    func save(name: String, period: String, country: String, sentence: String, imageDat: Data) {
        let philosopher = Philosopher(id: "\(id)", name: name, period: period, country: country, sentence: sentence, image: nil, imageDat: imageDat, isNew: true)
        services.create(philosopher: philosopher) { result in
            switch result {
            case .success:
                break
            case .failure:
                break
            }
        }
    }
}
