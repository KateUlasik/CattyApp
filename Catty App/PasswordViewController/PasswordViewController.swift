//
//  PasswordViewController.swift
//  Catty App
//
//  Created by Katerina Ulasik on 19.10.2021.
//

import UIKit

enum Spot {
    case collectionViewSpot
    case tableViewSpot
}

class PasswordViewController: UIViewController {
    var currentPassword: String = ""

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    @IBOutlet weak var button0: UIButton!
    
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func buttonDidTap(_ sender: Any) {
        if let button = sender as? UIButton, button == button1 {
            currentPassword = currentPassword + "1"
        } else if let button = sender as? UIButton, button == button2 {
            currentPassword = currentPassword + "2"
        } else if let button = sender as? UIButton, button == button3 {
            currentPassword = currentPassword + "3"
        }    else if let button = sender as? UIButton, button == button4 {
                currentPassword = currentPassword + "4"
        }    else if let button = sender as? UIButton, button == button5 {
                currentPassword = currentPassword + "5"
        }    else if let button = sender as? UIButton, button == button6 {
                currentPassword = currentPassword + "6"
        }    else if let button = sender as? UIButton, button == button7 {
                currentPassword = currentPassword + "7"
        }    else if let button = sender as? UIButton, button == button8 {
                currentPassword = currentPassword + "8"
        }    else if let button = sender as? UIButton, button == button9 {
                currentPassword = currentPassword + "9"
        }    else if let button = sender as? UIButton, button == button0 {
                currentPassword = currentPassword + "0"
    }

//      check password
        
        if currentPassword.count == Constants.passwordLength {
            let recoveredPassword = UserDefaults.standard.string(forKey: Constants.savePasswordKey)

            if let password = recoveredPassword, currentPassword == password {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    
                    self.showAlert(title: "Great", message: "Password is correct!") { _ in
                        NotificationCenter.default.post(name: NSNotification.Name.loadContentViewController, object: Spot.collectionViewSpot)
                    } openTableHandler: { _ in
                        NotificationCenter.default.post(name: NSNotification.Name.loadContentViewController, object: Spot.tableViewSpot)
                    }
                    
                    self.resetState()
                    
                }
                )
                
            } else {
                showAlert(title: "ERROR", message: "Password is wrong!", handler: {_ in } )
                resetState()
            }
            
        }
        
        if currentPassword.count >= 1 {
            imageView1.isHighlighted = true
        }
        
        if currentPassword.count >= 2 {
            imageView2.isHighlighted = true
        }
        
        if currentPassword.count >= 3 {
            imageView3.isHighlighted = true
        }
        
}
    
    private func resetState() {
        currentPassword = ""
        imageView1.isHighlighted = false
        imageView2.isHighlighted = false
        imageView3.isHighlighted = false
    }
    
    private func showAlert(title: String, message: String, handler: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let actionClose = UIAlertAction(title: "Close", style: .cancel, handler: handler)
     
        alert.addAction(actionClose)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showAlert(title: String, message: String, openCollectionHandler: @escaping (UIAlertAction) -> Void, openTableHandler: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let openCollectionAction = UIAlertAction(title: "Open in Collection", style: .default, handler: openCollectionHandler)
        let openTableAction = UIAlertAction(title: "Open in Table", style: .default, handler: openTableHandler)
     
        let actionClose = UIAlertAction(title: "Close", style: .cancel, handler: nil)
        
        alert.addAction(openCollectionAction)
        alert.addAction(openTableAction)
        alert.addAction(actionClose)
        self.present(alert, animated: true, completion: nil)
    }
    
}
    

    
    

