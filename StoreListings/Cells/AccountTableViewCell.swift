//
//  AccountTableViewCell.swift
//  StoreListings
//
//  Created by Kelvin CK Chan on 12/16/21.
//

import Foundation
import UIKit

class AccountTableViewCell: UITableViewCell {

    @IBOutlet weak var accountEmail: UILabel!
    
    @IBOutlet weak var accountPassword: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
