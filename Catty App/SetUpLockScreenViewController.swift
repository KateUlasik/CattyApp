//
//  ViewController.swift
//  Catty App
//
//  Created by Katerina Ulasik on 02.10.2021.
//

import UIKit

class SetUpLockScreenViewController: UIViewController {
//
//    @IBOutlet weak var tappableView: UIView! {
//         didSet {
//             tappableView.backgroundColor = .red
//         }
//     }
//
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var continueButton: UIButton!
    
    @IBOutlet weak var contentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
//
//        _ = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
//      }
//
//    @IBAction func didTapView(_ sender: UITapGestureRecognizer) {
//        print("did tap view", sender)
//    }
//
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
       
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        
        
//        scrollView.contentInset = UIEdgeInsets(top: 200, left: 0, bottom: 200, right: 0)
        
//        scrollView.contentOffset
//        scrollView.contentSize = CGSize(width: 200, height: 600)
        
//
//        contentView.layer.borderColor = UIColor.blue.cgColor
//        contentView.layer.borderWidth = 2
//
//        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
//
//          //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
//          //tap.cancelsTouchesInView = false
//
//          view.addGestureRecognizer(tap)
//      }
//
//      //Calls this function when the tap is recognized.
//      @objc func dismissKeyboard() {
//          //Causes the view (or one of its embedded text fields) to resign the first responder status.
//          view.endEditing(true)
//      }
//
        
    }
        @objc func keyboardWillShow(_ notification: NSNotification) {
            
            guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
            
            let keyboardScreenEndFrame = keyboardValue.cgRectValue
            let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
            
            let bottom = keyboardViewEndFrame.height - view.safeAreaInsets.bottom - 136
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottom, right: 0)
            
            scrollView.contentOffset = CGPoint(x: 0, y: bottom)
            
            
//        scrollView.contentInset = UIEdgeInsets(top: 200, left: 0, bottom: 200, right: 0)
//        scrollView.contentSize = CGSize(width: 200, height: 600)
//            print(notification)
        }
        
        @objc func keyboardDidHide(_ notification: NSNotification) {
        scrollView.contentInset = .zero
//        scrollView.contentSize = .zero
        }
}


