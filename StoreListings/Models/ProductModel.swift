//
//  ProductModel.swift
//  StoreListings
//
//  Created by Kelvin CK Chan on 12/16/21.
//

import Foundation
import UIKit

struct Product: Codable{

    let id: String
    let image: String
    let name: String
    
    init(name1: String, image1: String, id1: String){
        name = name1
        image = image1
        id = id1
    }
}
