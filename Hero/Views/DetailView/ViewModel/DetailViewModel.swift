//
//  DetailViewModel.swift
//  Hero
//
//  Created by Byron Mejia on 12/23/22.
//

import UIKit
import Combine

protocol DetailViewModelRepresentable {
    var philosopher: Philosopher { get }
}

final class DetailViewModel<R: AppRouter> {
    var router: R?
    let philosopher: Philosopher
    
    init(model: Philosopher) {
        self.philosopher = model
    }
}

extension DetailViewModel: DetailViewModelRepresentable { }
