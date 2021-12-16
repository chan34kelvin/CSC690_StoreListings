//
//  StoreModel.swift
//  StoreListings
//
//  Created by Kelvin CK Chan on 12/16/21.
//

import Foundation
import UIKit

struct Store: Codable{
    struct Products: Codable{
        struct Account: Codable {
            let email: String
            let password: String
        }
        var diskAccounts: [Account]
        var digiAccounts: [Account]
        var xboxAccounts: [Account]
        init() {
            diskAccounts = []
            digiAccounts = []
            xboxAccounts = []
        }
    }
    let products: Products
    let address: String
    let name: String
    
    init(name1: String, addr: String){
        name = name1
        address = addr
        products = Products.init()
    }
    
    init(targetStore: TargetStore) {
        name = targetStore.locationName
        address = targetStore.mailingAddress.description
        products = Products.init()
    }
}

