//
//  AccountViewController.swift
//  StoreListings
//
//  Created by Kelvin CK Chan on 12/16/21.
//

import Foundation
import UIKit

//check status if your product is ready for pickup
class AccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var accountView: UITableView!
    
    @IBOutlet weak var productPicture: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productId: UILabel!
    
    //storage
    let encoder = JSONEncoder()
    let defaults = UserDefaults.standard
    //class vars
    var zip: String = ""
    var storeName: String = ""
    var storeAddress: String = ""
    var productName: String = ""
    var productsId: String = ""
    var productImage: String = ""
    
    //array of stores
    var accountItems: [Account] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productTitle.text = productName
        productPicture.image = UIImage(named: productImage)
        productId.text = "Type:" + productsId
        
        //getting accounts with key
        let key = zip + storeName + storeAddress + productName + productsId
        //getting accs from storage
        if let savedAccs = defaults.object(forKey: key) as? Data {
                let decoder = JSONDecoder()
                if let mySavedAccs = try? decoder.decode([Account].self, from: savedAccs) {
                        accountItems = (mySavedAccs)
                }
            }
        
        accountView.delegate = self
        accountView.dataSource = self
        updateAccounts()
    }
    
    func setAccount(newEmail: String, newPassword: String){
        
        var status:String = "ready to pick up"
        //just for mimic purpose since no actual login yet
        print(Int.random(in: 1..<3))
        if(Int.random(in: 1..<3) == 1){
            status = "not ready to pick up"
        }

        let newAccount = Account(email1: newEmail, password1: newPassword, status1: status)
        
        if(accountItems[0].email == "No accs yet"){
            accountItems[0] = newAccount
        }else{
            accountItems.append(newAccount)
        }
        
        let key = zip+storeName+storeAddress+productName+productsId
        //store updated accounts
        if let encoded = try? encoder.encode(accountItems) {
            defaults.set(encoded, forKey: key)
        }
        
        updateAccounts()
    }
    
    func updateAccounts(){
        print(accountItems.count)
        if(accountItems.count == 0){
            accountItems.append(Account(email1: "No accs yet", password1: "test123", status1: "Login to follow"))
        }
        accountView.reloadData()
    }
    
    //called when going to get store items
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? LoginController{
            dest.delegate = self
        }
    }
    
    //height of the table view cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    //this one decides how many rows are show
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AccountCell", for: indexPath) as? AccountTableViewCell else {
            return UITableViewCell()
        }

        let account = accountItems[indexPath.row]
        cell.accountEmail.text = "Account: "+account.email
        cell.accountStatus.text = "Stat: "+account.status
        
        return cell
    }
}
