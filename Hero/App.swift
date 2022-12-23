//
//  App.swift
//  Hero
//
//  Created by Byron Mejia on 12/23/22.
//

import UIKit

final class App {
    var navigationController = UINavigationController()
    private var coordinatorRegister: [AppTransition: Coordinator] = [:]
}

extension App: Coordinator {
    func start() {
        process(route: .showMainScreen)
    }
}

extension App: AppRouter {
    
    func exit() {
        /// In this Router context - the only exit left is the main screen.
        /// Logout - clean tokens - local cache - offline database if needed etc.
    }
    
    func process(route: AppTransition) {
        let coordinator = route.hasState ? coordinatorRegister[route] : route.coordinatorFor(router: self)
        coordinator?.start()
    }
}
