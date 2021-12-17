//
//  CustomCollectionViewCell.swift
//  collectionView for CattyApp
//
//  Created by Katerina Ulasik on 28.11.2021.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var parentViewController: TagsCollectionViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        self.contentView.layer.borderColor = UIColor.gray.cgColor
        self.contentView.layer.borderWidth = 2
        self.contentView.layer.cornerRadius = 25
        self.contentView.clipsToBounds = true
    }

    @IBAction func favoriteButtonHandler(_ sender: Any) {
        favoriteButton.isSelected = !favoriteButton.isSelected
        
        if let tag = titleLabel.text, favoriteButton.isSelected == true {
            parentViewController?.addToFavorites(tag: tag)
        } else if let tag = titleLabel.text, favoriteButton.isSelected == false {
            
            parentViewController?.removeFromFavorites(tag: tag)
            }
    }
    
            func restButtonPressed(_ sender: Any) {
        print("rest mode button is pressed and i am showing a overlay right now with data count down")
    }
    
    func configure(tag: String, isSelected: Bool, parentViewController: TagsCollectionViewController?) {
        self.titleLabel.text = tag
        self.favoriteButton.isSelected = isSelected
        self.parentViewController = parentViewController
    }
    
}

