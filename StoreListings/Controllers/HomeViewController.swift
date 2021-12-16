//
//  ViewController.swift
//  StoreListings
//
//  Created by Kelvin CK Chan on 12/15/21.
//

import UIKit

class HomeViewController: UIViewController {

    //class variable
    var zip: String = ""
    
    //storage
    let encoder = JSONEncoder()
    let defaults = UserDefaults.standard
    
    //this view controller gets zip from user default
    //if is null, then stay on the page
    //if it has data, then go to store controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //getting zip from storage
        if let savedZip = defaults.object(forKey: "zip") as? Data {
                let decoder = JSONDecoder()
                if let mySavedZip = try? decoder.decode(String.self, from: savedZip) {
                    zip = (mySavedZip)
                }
            }
        
        //this means the zip code already exist, skip to listing
        if(zip != ""){
            goToStores()
        }
//        logo.image = UIImage(named: "logo")
//        logo.contentMode = .scaleAspectFit
        // Do any additional setup after loading the view.
    }
    
    func setZipCode(newZip: String){
        print(newZip)
        zip = newZip
        //save into storage
        if let encoded = try? encoder.encode(zip) {
            defaults.set(encoded, forKey: "zip")
        }
        goToStores()
    }
    
    func goToStores(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "StoreViewController") as? StoreViewController
        vc?.zip = zip
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    //called when going to add zip code
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? AddZipCodeController{
            dest.delegate = self
        }
    }


}

