//
//  MainListViewModel.swift
//  Hero
//
//  Created by Byron Mejia on 12/23/22.
//

import UIKit
import Combine

protocol MainViewModelViewDelegate {
    func refreshScreen(items: [Philosopher])
    func showError()
}

protocol MainListViewModelRepresentable {
    func getPhilosophers()
    func didTapItem(model: Philosopher)
    func goToAddNew()
    var delegate: MainViewModelViewDelegate? { get set }
}

final class MainListViewModel<R: AppRouter> {
    var router: R?
    var delegate: MainViewModelViewDelegate?
    private var cancellables = Set<AnyCancellable>()
    private let store: MainListStore
    
    private var fetchedPhilosophers = [Philosopher]()
    
    var services: Serviceable
    
    init(store: MainListStore = APIManager(), services: Serviceable) {
        self.store = store
        self.services = services
        loadData()
    }
}

extension MainListViewModel: MainListViewModelRepresentable {
    
    func getPhilosophers() {
        services.fetch { [unowned self] result in
            switch result {
            case .success(let philosopherManagedObjects):
                let philosophers = philosopherManagedObjects.compactMap {
                    PhilosopherObject(nsManagedObject: $0).philosopher
                }
                fetchedPhilosophers = philosophers
                delegate?.refreshScreen(items: philosophers)
            case .failure:
                delegate?.showError()
            }
        }
    }
    
    func loadData() {
        let recievedPhilosopher = { (response: Response) -> Void in
            DispatchQueue.main.async { [unowned self] in
                services.saveDataOf(philosophers: response.Philosopher)
                if UserDefaultsManager.isFirstLaunch {
                    delegate?.refreshScreen(items: response.Philosopher)
                    UserDefaultsManager.isFirstLaunch = false
                }
            }
        }
        
        let completion = { [unowned self] (completion: Subscribers.Completion<Failure>) -> Void in
            switch  completion {
            case .finished:
                break
            case .failure:
                if !fetchedPhilosophers.isEmpty {
                    delegate?.showError()
                }
                break
            }
        }
        
        store.getPhilosophers()
            .sink(receiveCompletion: completion, receiveValue: recievedPhilosopher)
            .store(in: &cancellables)
    }
    
    func goToAddNew() {
        let id = fetchedPhilosophers.count + 1
        router?.process(route: .showAddNew(model: id))
    }
    
    func didTapItem(model: Philosopher) {
        router?.process(route: .showDetail(model: model))
    }
}
