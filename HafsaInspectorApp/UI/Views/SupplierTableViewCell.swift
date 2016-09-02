//
//  SupplierTableViewCell.swift
//  HafsaInspectorApp
//
//  Created by Junaid Mahmood on 8/31/16.
//  Copyright © 2016 Mahmood. All rights reserved.
//

import UIKit

class SupplierTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var supplierNameLabel: UILabel!
    @IBOutlet weak var poundLabel: UILabel!
    
    private let HImanager = HIManager.sharedClient()
    var previousPounds: Double = 0.0
    var tField: UITextField!


    func configureSupplierCell(index: Int) {
        supplierNameLabel.text = HImanager.supplierArray[index]
        poundLabel.text = "\(previousPounds) lbs"
    }
    
    func updatePounds(pounds: Double) {
        previousPounds = previousPounds + pounds
        dispatch_async(dispatch_get_main_queue()) {
            self.poundLabel.text = "\(self.previousPounds) lbs"
        }
    }
    
    @IBAction func addPoundsPressed(sender: AnyObject) {
        let alert = UIAlertController(title: "Enter Input", message: "", preferredStyle: .Alert)
        alert.addTextFieldWithConfigurationHandler(configurationTextField)
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler:nil))
        alert.addAction(UIAlertAction(title: "Done", style: .Default, handler:{ (UIAlertAction) in
            self.updatePounds(Double(self.tField.text!)!)
        }))
        
        if let wd = self.window {
            var vc = wd.rootViewController
            if(vc is UINavigationController){
                vc = (vc as! UINavigationController).visibleViewController
            }
            if(vc is FormTableViewController){
                vc?.presentViewController(alert, animated: true, completion:nil)
            }
        }
    }
    
    func configurationTextField(textField: UITextField!) {
        textField.placeholder = "Enter an item"
        textField.keyboardType = UIKeyboardType.DecimalPad
        tField = textField
    }
    
}
    

