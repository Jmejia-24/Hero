//
//  AppTransition.swift
//  Hero
//
//  Created by Byron Mejia on 12/23/22.
//

import Foundation

enum AppTransition {
    
    case showMainScreen
    case showDetail(model: Philosopher)
    case showAddNew(model: Int)
    
    var hasState: Bool {
        /// If some transitions need to have state - perform case match logic here
        /// Generally prefer stateless
        false
    }
    
    func coordinatorFor<R: AppRouter>(router: R) -> Coordinator {
        switch self {
        case .showMainScreen: return MainListCoordinator(router: router)
        case .showDetail(let model): return DetailCoordinator(model: model, router: router)
        case .showAddNew(let model): return AddNewPhilosopherCoordinator(model: model, router: router)
        }
    }
}

extension AppTransition: Hashable {
    
    var identifier: String {
        switch self {
        case .showMainScreen: return "showMainScreen"
        case .showDetail: return "showDetail"
        case .showAddNew: return "showAddNew"
        }
    }
    
    static func == (lhs: AppTransition, rhs: AppTransition) -> Bool {
        lhs.identifier == rhs.identifier
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}

