//
//  SetStoreItemController.swift
//  StoreListings
//
//  Created by Kelvin CK Chan on 12/16/21.
//

import Foundation
import UIKit

class SetZipCodeController: UIViewController {
    
    //Yes, this is literally samething as addzipcodecontroller but
    //i dont wanna call it that so XD
    //test
    var clicked: Bool = false
    //find the zip code and return it
    var delegate : StoreViewController?
    
    @IBOutlet weak var zipCodeInput: UITextField!
    
    //now get the zip code and store it
    var zipCode: String? {
        guard
            let input = zipCodeInput.text
        else{
            return nil
        }
        return input
    }

    //use fetch to get stores

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

