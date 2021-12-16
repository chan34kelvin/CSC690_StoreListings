//
//  StoreViewController.swift
//  StoreListings
//
//  Created by Kelvin CK Chan on 12/15/21.
//

import Foundation
import UIKit

class StoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var zipLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var storeView: UITableView!
    
    //storage
    let encoder = JSONEncoder()
    let defaults = UserDefaults.standard
    //class vars
    var zip: String = "94134"
    let storeFinder = TargetStoreFinder()
    //array of stores
    var storeItems: [Store] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        zipLabel.text = zip
        storeView.delegate = self
        storeView.dataSource = self
        getStores()
    }
    
    func setZipCode(newZip: String){
        //update label with new zip
        zipLabel.text = newZip
        zip = newZip
        
        //store updated zip
        if let encoded = try? encoder.encode(zip) {
            defaults.set(encoded, forKey: "zip")
        }
        
        getStores()
    }
    
    func getStores(){
        storeFinder.getStores(where: zip) {
            stores in
            var myStores: [Store] = []
            for store in stores {
                var myStore: Store = Store.init(targetStore: store)
                myStores.append(myStore)
            }
            DispatchQueue.main.async(){self.updateStores(newStores: myStores)}
        }
    }
    
    func updateStores(newStores: [Store]){
        storeItems = newStores
        titleLabel.text = String(storeItems.count) + " Stores in:"
        if(storeItems.count == 0){
            storeItems.append(Store(name1: "No stores found", addr: "Please enter a new zip code"))
        }
        storeView.reloadData()
    }
    
    //called when going to get store items
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? SetZipCodeController{
            dest.delegate = self
        }
    }
    
    //height of the table view cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }

    //this one decides how many rows are show
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeItems.count
    }
    
    //called when pressed cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //if zip isnt valid, stop the process
        if(storeItems[indexPath.row].name == "No stores found"){
            return
        }
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProductViewController") as? ProductViewController
        vc?.store = storeItems[indexPath.row].name
        vc?.address = storeItems[indexPath.row].address
        vc?.zip = zip
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StoreCell", for: indexPath) as? StoreTableViewCell else {
            return UITableViewCell()
        }

        let store = storeItems[indexPath.row]
        cell.storeName.text = "Store: "+store.name
        cell.storeAddress.text = "Address: "+store.address
        
        return cell
    }
}
