//
//  SupplierTableViewCell.swift
//  HafsaInspectorApp
//
//  Created by Junaid Mahmood on 8/31/16.
//  Copyright © 2016 Mahmood. All rights reserved.
//

import UIKit

class SupplierTableViewCell: UITableViewCell {
    @IBOutlet weak var supplierNameLabel: UIView!

    @IBOutlet weak var poundLabel: UILabel!
    
    var pounds = 0
    
    @IBAction func addPoundPressed(sender: AnyObject) {
        
    }
    
}
