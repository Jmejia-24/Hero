//
//  AddNewPhilosopherViewModel.swift
//  Hero
//
//  Created by Byron Mejia on 12/23/22.
//

import Foundation

protocol AddNewPhilosopherViewModelRepresentable {
    func save()
}

final class AddNewPhilosopherViewModel<R: AppRouter> {
    var router: R?
    let id: Int
    
    init(model: Int) {
        self.id = model
    }
}

extension AddNewPhilosopherViewModel: AddNewPhilosopherViewModelRepresentable {
    func save() {
        
    }
}
