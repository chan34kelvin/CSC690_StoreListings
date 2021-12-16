//
//  AccountModel.swift
//  StoreListings
//
//  Created by Kelvin CK Chan on 12/16/21.
//

import Foundation
import UIKit

struct Account: Codable{

    let password: String
    let email: String
    let status: String
    
    init(email1: String, password1: String, status1: String){
        email = email1
        password = password1
        status = status1
    }
}
