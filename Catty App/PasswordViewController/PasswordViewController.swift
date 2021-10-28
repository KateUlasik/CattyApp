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
        }
        
        if currentPassword.count == 6 {
            let recoveredPassword = UserDefaults.standard.string(forKey: Constants.savePasswordKey)
            
            if let password = recoveredPassword, currentPassword == password {
                print("Success!")
            } else {
                print("Wrong!")
            }
            
            currentPassword = ""
        }
    }
    
}
