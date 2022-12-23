//
//  Router.swift
//  Hero
//
//  Created by Byron Mejia on 12/23/22.
//

import UIKit

protocol Router: AnyObject {
    associatedtype Route
    var navigationController: UINavigationController { get set }
    func exit()
    func process(route: Route)
}

protocol AppRouter: Router where Route == AppTransition { }
