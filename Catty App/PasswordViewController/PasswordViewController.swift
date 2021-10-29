//
//  PasswordViewController.swift
//  Catty App
//
//  Created by Katerina Ulasik on 19.10.2021.
//

import UIKit

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
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
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
        
        if currentPassword.count == 6 {
            let recoveredPassword = UserDefaults.standard.string(forKey: Constants.savePasswordKey)
            
            if let password = recoveredPassword, currentPassword == password {
//                showAlert(title: "Great", message: "Password is correct!")
                print("correct!!")
            } else {
//                showAlert(title: "ERROR", message: "Password is wrong!")
                print("wrong!!")
            }

            currentPassword = ""
        }
    }
}
}
