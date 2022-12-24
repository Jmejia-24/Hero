//
//  AddNewPhilosopherCoordinator.swift
//  Hero
//
//  Created by Byron Mejia on 12/23/22.
//

import UIKit

final class AddNewPhilosopherCoordinator<R: AppRouter> {
    
    let router: R
    var model: Int
    
    init(model: Int, router: R) {
        self.model = model
        self.router = router
    }
    
    private lazy var primaryViewController: UIViewController = {
        let viewModel = AddNewPhilosopherViewModel<R>(model: self.model)
        viewModel.router = router
        let viewController = AddNewPhilosopherViewController(viewModel: viewModel)
        return viewController
    }()
}

extension AddNewPhilosopherCoordinator: Coordinator {
    func start() {
        router.navigationController.pushViewController(primaryViewController, animated: true)
    }
}
