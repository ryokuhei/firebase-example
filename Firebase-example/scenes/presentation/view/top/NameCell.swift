//
//  NameCell.swift
//  Firebase-example
//
//  Created by ryoku on 2018/02/19.
//  Copyright © 2018 ryoku. All rights reserved.
//

import Foundation
import UIKit

class NameCell : UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func setName(name: String) {
        nameLabel.text = name
    }
    
}
