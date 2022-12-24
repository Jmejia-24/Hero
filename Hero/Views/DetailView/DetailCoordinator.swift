//
//  DetailCoordinator.swift
//  Hero
//
//  Created by Byron Mejia on 12/23/22.
//

import UIKit

final class DetailCoordinator<R: AppRouter> {
    
    let router: R
    var model: Philosopher
    
    init(model: Philosopher, router: R) {
        self.model = model
        self.router = router
    }
    
    private lazy var primaryViewController: UIViewController = {
        let viewModel = DetailViewModel<R>(model: self.model)
        viewModel.router = router
        let viewController = DetailViewController(viewModel: viewModel)
        return viewController
    }()
}

extension DetailCoordinator: Coordinator {
    func start() {
        router.navigationController.pushViewController(primaryViewController, animated: true)
    }
}

