//
//  MainListViewModel.swift
//  Hero
//
//  Created by Byron Mejia on 12/23/22.
//

import UIKit
import Combine

protocol MainListViewModelRepresentable {
    func loadData()
    func didTapItem(model: Philosopher)
    func goToAddNew()
    var philosophersSubject: PassthroughSubject<[Philosopher], Failure> { get }
}

final class MainListViewModel<R: AppRouter> {
    var router: R?
    let philosophersSubject = PassthroughSubject<[Philosopher], Failure>()
    
    private var cancellables = Set<AnyCancellable>()
    private let store: MainListStore
    
    private var fetchedPhilosopherss = [Philosopher]() {
        didSet {
            philosophersSubject.send(fetchedPhilosopherss)
        }
    }
    
    init(store: MainListStore = APIManager()) {
        self.store = store
    }
}

extension MainListViewModel: MainListViewModelRepresentable {
    func loadData() {
        let recievedPhilosopher = { (response: Response) -> Void in
            DispatchQueue.main.async { [unowned self] in
                fetchedPhilosopherss.append(contentsOf: response.filosofos)
            }
        }
        
        let completion = { [unowned self] (completion: Subscribers.Completion<Failure>) -> Void in
            switch  completion {
            case .finished:
                break
            case .failure(let failure):
                philosophersSubject.send(completion: .failure(failure))
            }
        }
        
        store.getPhilosophers()
            .sink(receiveCompletion: completion, receiveValue: recievedPhilosopher)
            .store(in: &cancellables)
    }
    
    func goToAddNew() {
        
    }
    
    func didTapItem(model: Philosopher) {
        
    }
}
