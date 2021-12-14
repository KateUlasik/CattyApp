//
//  CustomCollectionViewCell.swift
//  collectionView for CattyApp
//
//  Created by Katerina Ulasik on 28.11.2021.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var customLabel: UILabel!
    
    func configure(tag: String) {
        customLabel.text = tag
    }
    
}
