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
    @IBOutlet weak var addPoundsButton: UIButton!
    
    fileprivate let HImanager = HIManager.sharedClient()
    var previousPounds: Double = 0.0
    var tField: UITextField!


    func configureSupplierCell(_ index: Int, data: NSArray) {
        self.selectionStyle = UITableViewCellSelectionStyle.none

        supplierNameLabel.text = data[index] as? String
        poundLabel.text = "\(previousPounds) lbs"
        self.backgroundColor = UIColor.clear
        
        supplierNameLabel.font = UIFont(name: "AvenirNext-Medium", size: 16)
        supplierNameLabel.textColor = UIColor.darkGray
        poundLabel.font = UIFont(name: "AvenirNext-Medium", size: 16)
        poundLabel.textColor = UIColor.darkGray
        
        addPoundsButton.backgroundColor = UIColor.white
        addPoundsButton.tintColor = UIColor.black
        addPoundsButton.titleLabel?.textColor = UIColor.black
        addPoundsButton.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 16)
        addPoundsButton.layer.cornerRadius = 4
        addPoundsButton.layer.borderWidth = 1
        addPoundsButton.layer.borderColor = UIColor.black.cgColor
    }
    
    func updatePounds(_ pounds: Double) {
        previousPounds = previousPounds + pounds
        DispatchQueue.main.async {
            self.poundLabel.text = "\(self.previousPounds) lbs"
        }
        
        for supplier in HImanager.supplierValues {
            let sup = supplier as! NSDictionary
            if (sup.allKeys[0] as! String) == supplierNameLabel.text {
                HImanager.supplierValues.remove(supplier)
            }
        }
        HImanager.supplierValues.add([supplierNameLabel.text:"\(self.previousPounds) lbs"] as NSDictionary)
    }
    
    @IBAction func addPoundsPressed(_ sender: AnyObject) {
        let alert = UIAlertController(title: "Enter lbs", message: "", preferredStyle: .alert)
        alert.addTextField(configurationHandler: configurationTextField)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler:{ (UIAlertAction) in
            if !(self.tField.text?.isEmpty)! {
                self.updatePounds(Double(self.tField.text!)!)
            }
        }))
        
        let vc = self.parentViewController
        vc?.present(alert, animated: true, completion:nil)
        
    }
    
    func configurationTextField(_ textField: UITextField!) {
        textField.placeholder = "Enter a number"
        textField.keyboardType = UIKeyboardType.decimalPad
        tField = textField
    }
    
}
    

