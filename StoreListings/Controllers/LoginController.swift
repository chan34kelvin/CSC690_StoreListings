//
//  LoginController.swift
//  StoreListings
//
//  Created by Kelvin CK Chan on 12/16/21.
//

import Foundation
import UIKit

class LoginController: UIViewController {
    
    
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    //test
    var clicked: Bool = false
    //get login and return it
    var delegate : AccountViewController?
    
    //store login info
    var email: String? {
        guard
            let input = emailInput.text
        else{
            return nil
        }
        return input
    }
    
    var password: String? {
        guard
            let input = passwordInput.text
        else{
            return nil
        }
        return input
    }

    //give email and password back
    @IBAction func dismiss(_ sender: Any) {
        guard let email = email else {
            print("error in email")
            return
        }
        guard let password = password else {
            print("error in password")
            return
        }
        
        if(!clicked){
            print("acc success")
            delegate?.setAccount(newEmail: email, newPassword: password)
            clicked = true
        }
        //go back to home screen
        
        self.dismiss(animated: true, completion: nil)
    }
}
