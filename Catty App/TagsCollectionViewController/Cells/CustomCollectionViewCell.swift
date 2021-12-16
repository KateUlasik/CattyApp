//
//  CustomCollectionViewCell.swift
//  collectionView for CattyApp
//
//  Created by Katerina Ulasik on 28.11.2021.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var customLabel: UILabel!
    @IBOutlet weak var restButton: UIImageView!
    @IBOutlet weak var startButton: UIImageView!

    @IBAction func startButtonPressed(_ sender: Any) {
//        startButton.isHidden = true
//        startButton.isUserInteractionEnabled = false
//        perform(#selector, Selector, with: 1, afterDelay: 10)
//            timeLeft = 0
//            myTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(workoutStartVC.timerRunning), userInfo: nil, repeats: true)
    }
    
            func restButtonPressed(_ sender: Any) {
        print("rest mode button is pressed and i am showing a overlay right now with data count down")
    }
    
    func configure(tag: String) {
        customLabel.text = tag
    }
    
}

