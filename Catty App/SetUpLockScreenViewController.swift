//
//  ViewController.swift
//  Catty App
//
//  Created by Katerina Ulasik on 02.10.2021.
//

import UIKit

struct Constants {
    static let savePasswordKey = "our_password"
}

class SetUpLockScreenViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet var contentViewTapGestureRecognizer: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        
        contentViewTapGestureRecognizer.addTarget(self, action: #selector(contentViewDidTap(_:)))
        
    }
    @objc func keyboardWillShow(_ notification: NSNotification) {
        
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        let bottom = keyboardViewEndFrame.height - view.safeAreaInsets.bottom - 136
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottom, right: 0)
        
        scrollView.contentOffset = CGPoint(x: 0, y: bottom)
    }
    
    @objc func keyboardDidHide(_ notification: NSNotification) {
        scrollView.contentInset = .zero
    }
    
    @objc func contentViewDidTap(_ sender: Any) {
        passwordTextField.resignFirstResponder()
    }
    
    @IBAction func continueDidPress(_ sender: Any) {
        let password = passwordTextField.text
        
        if let password = password, password.count == 6 {
            UserDefaults.standard.set(password, forKey: Constants.savePasswordKey)
            print("Password was saved saccessful")
        } else {
            passwordTextField.text = "Wrong password..."
        }
    }
    
    @IBAction func recoverPssDidPress(_ sender: Any) {
        let password = UserDefaults.standard.string(forKey: Constants.savePasswordKey)
        passwordTextField.text = "Recovered password is \(password)"
    }
    
}


