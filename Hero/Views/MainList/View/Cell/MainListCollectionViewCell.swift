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
    }

    func configCell(philosopher: Philosopher) {
        nameLabel.text = philosopher.name
        
        if let image = philosopher.image, !image.isEmpty, let uiImage = UIImage(named: image)  {
            imageView.image = uiImage
            return
        } else if let imageData = philosopher.imageDat {
            imageView.image = UIImage(data: imageData)
            return
        } else {
            imageView.image = UIImage(named: "placeholder")
            return
        }
    }
}
