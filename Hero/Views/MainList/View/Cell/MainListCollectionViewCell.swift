//
//  MainListCollectionViewCell.swift
//  Hero
//
//  Created by Byron Mejia on 12/23/22.
//

import UIKit

class MainListCollectionViewCell: UICollectionViewCell, NibLoadable {
     
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configCell(philosopher: Philosopher) {
        nameLabel.text = philosopher.name
        imageView.image = UIImage(named: philosopher.image ?? "")
    }
}
