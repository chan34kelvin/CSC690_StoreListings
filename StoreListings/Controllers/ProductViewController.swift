//
//  ProductViewController.swift
//  StoreListings
//
//  Created by Kelvin CK Chan on 12/16/21.
//

import Foundation
import UIKit

class ProductViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var resultsLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var storeLabel: UILabel!
    @IBOutlet weak var productView: UITableView!
    
    //storage
    let encoder = JSONEncoder()
    let defaults = UserDefaults.standard
    //class vars
    var zip: String = ""
    var store: String = ""
    var address: String = ""
    //array of products
    var productItems: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storeLabel.text = store
        addressLabel.text = address
        
        getProducts()
        resultsLabel.text = String(productItems.count)+" products listed"
        productView.delegate = self
        productView.dataSource = self
    }
    
    func getProducts(){
        let product1 = Product(name1: "ps5 digital", image1: "ps5digital", id1: "1874567ATR")
        productItems.append(product1)
        let product2 = Product(name1: "ps5 disc", image1: "ps5disc", id1: "67eARFRG34")
        productItems.append(product2)
        let product3 = Product(name1: "xbox", image1: "xbox", id1: "18er5667TA")
        productItems.append(product3)
    }
    
    //height of the table view cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    //this one decides how many rows are show
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productItems.count
    }
    
    //called when pressed cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AccountViewController") as? AccountViewController
        vc?.productName = productItems[indexPath.row].name
        vc?.productImage = productItems[indexPath.row].image
        vc?.productsId = productItems[indexPath.row].id
        vc?.zip = zip
        vc?.storeName = store
        vc?.storeAddress = address
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProductTableViewCell else {
            return UITableViewCell()
        }

        let product = productItems[indexPath.row]
        cell.productName.text = product.name
        cell.productId.text = "ID: "+product.id
        cell.productImage.image = UIImage(named: product.image)
        
//        cell.storeTitleLabel.text = store.storeName
//        cell.storeDescriptionLabel.text = "test12"
        return cell
    }
}
