//
//  DetailViewController.swift
//  Hero
//
//  Created by Byron Mejia on 12/23/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var periodoLabel: UILabel!
    @IBOutlet private var paisLabel: UILabel!
    @IBOutlet private var fraseLabel: UILabel!
    
    private let viewModel: DetailViewModelRepresentable
    
    init(viewModel: DetailViewModelRepresentable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI() {
        nameLabel.text = viewModel.philosopher.name
        periodoLabel.text = viewModel.philosopher.period
        paisLabel.text = viewModel.philosopher.country
        fraseLabel.text = viewModel.philosopher.sentence
        
        if let image = viewModel.philosopher.image, !image.isEmpty, let uiImage = UIImage(named: image)  {
            imageView.image = uiImage
            return
        } else if let imageData = viewModel.philosopher.imageDat {
            imageView.image = UIImage(data: imageData)
            return
        } else {
            imageView.image = UIImage(named: "placeholder")
            return
        }
    }
}
