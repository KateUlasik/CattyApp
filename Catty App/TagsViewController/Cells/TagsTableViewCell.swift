//
//  TagsTableViewCell.swift
//  Catty App
//
//  Created by Katerina Ulasik on 16.11.2021.
//

import UIKit

class TagsTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet weak var imageViewCell: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(tag: String) {
        titleLabel.text = tag
    }
    
}
