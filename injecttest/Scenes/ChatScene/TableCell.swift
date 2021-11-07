//
//  TableCell.swift
//  injecttest
//
//  Created by Berkin Tatlısu on 6.11.2021.
//

import Foundation
import UIKit

class TableCell:UITableViewCell{
    @IBOutlet weak var from: UILabel!
    @IBOutlet weak var message: UILabel!
    var datetime:String = ""    
}
