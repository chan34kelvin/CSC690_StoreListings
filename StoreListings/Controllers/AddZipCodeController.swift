//
//  AddZipCodeController1.swift
//  StoreListings
//
//  Created by Kelvin CK Chan on 12/15/21.
//

import Foundation
import UIKit

class AddZipCodeController: UIViewController {
    
    //test
    var clicked: Bool = false
    //finds the zip code and return it
    var delegate : HomeViewController?
    
    @IBOutlet weak var zipCodeInput: UITextField!
    
    //        now get the zip code and store it
    var zipCode: String? {
        guard
            let input = zipCodeInput.text
        else{
            return nil
        }
        return input
    }

    //give zip code back
    @IBAction func dismiss(_ sender: Any) {
        guard let zipCode = zipCode else {
            print("error in zip code")
            return
        }
        
        if(!clicked){
            print("test success")
            delegate?.setZipCode(newZip: zipCode)
            clicked = true
        }
        //go back to home screen
        
//        DispatchQueue.main.async(){self.delegate?.setZipCode(newZip: zipCode)}
        self.dismiss(animated: true, completion: nil)
    }
}
