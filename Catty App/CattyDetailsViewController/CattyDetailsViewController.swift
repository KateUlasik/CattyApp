//
//  CattyDetailsViewController.swift
//  Catty App
//
//  Created by Katerina Ulasik on 16.11.2021.
//

import UIKit

class CattyDetailsViewController: UIViewController {

    @IBOutlet weak var catsImageView: UIImageView!
    
    private var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.catsImageView.image = image
        self.navigationItem.title = "Catty image"
    }
    
    func configure(image: UIImage?) {
        self.image = image
        
        if let imageView = catsImageView {
            imageView.image = image
        }
    }
}
