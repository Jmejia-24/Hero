//
//  MainListCoordinator.swift
//  Hero
//
//  Created by Byron Mejia on 12/23/22.
//

import UIKit

final class MainListCoordinator<R: AppRouter> {
    
    let router: R

    init(router: R) {
        self.router = router
    }
    
    private lazy var primaryViewController: UIViewController = {
        let viewModel = MainListViewModel<R>(services: Services(storage: PhilosopherManager()))
        viewModel.router = router
        let viewController = MainListViewController(viewModel: viewModel)
        return viewController
    }()
}

extension MainListCoordinator: Coordinator {
    func start() {
        router.navigationController.pushViewController(primaryViewController, animated: true)
    }
}
