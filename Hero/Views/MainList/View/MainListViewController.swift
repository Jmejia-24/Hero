//
//  MainListViewController.swift
//  Hero
//
//  Created by Byron Mejia on 12/23/22.
//

import UIKit
import Combine

final class MainListViewController: UICollectionViewController {
    private enum Section: CaseIterable {
        case main
    }
    
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Philosopher>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Philosopher>
    
    private var subscription: AnyCancellable?
    private var segmentedControlSubscription: AnyCancellable?
    
    private var viewModel: MainListViewModelRepresentable
    
    init(viewModel: MainListViewModelRepresentable) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: Self.generateLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static private func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(200))
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
            
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
        return layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bindUI()
    }
    
    override func loadView() {
        super.loadView()
    }
    
    // MARK: - Private methods
    
    private func setBarItem() {
        let addButtonItem = UIBarButtonItem(title: "Agregar", primaryAction: UIAction { [unowned self] _ in
            
        })
        
        navigationItem.rightBarButtonItem = addButtonItem
    }
    
    private func setUI() {
        navigationItem.setHidesBackButton(true, animated: false)
        title = "Filosofos"
        collectionView.register(MainListCollectionViewCell.self)
        collectionView.bounces = false
        collectionView.showsVerticalScrollIndicator = false
        setBarItem()
        applySnapshot(items: [])
        viewModel.loadData()
    }
    
    private func bindUI() {
        subscription = viewModel.philosophersSubject.sink { [unowned self] completion in
            switch completion {
            case .finished:
                print("Received completion in VC", completion)
            case .failure(let error):
                print(error.localizedDescription)
//                presentErrorAlert(for: error.errorCode.rawValue, with: error.message)
            }
        } receiveValue: { [unowned self] items in
            applySnapshot(items: items)
        }
    }
    
    private lazy var dataSource: DataSource = {
        let dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, item ->  UICollectionViewCell in
            let cell: MainListCollectionViewCell = collectionView.dequeueCell(for: indexPath)
            cell.configCell(philosopher: item)
            return cell
        }
        return dataSource
    }()

    private func applySnapshot(items: [Philosopher]) {
        var snapshot = Snapshot()
        snapshot.appendSections(Section.allCases)
        Section.allCases.forEach { snapshot.appendItems(items, toSection: $0) }
        dataSource.apply(snapshot)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = dataSource.itemIdentifier(for: indexPath) else { return }
        viewModel.didTapItem(model: movie)
    }
}
