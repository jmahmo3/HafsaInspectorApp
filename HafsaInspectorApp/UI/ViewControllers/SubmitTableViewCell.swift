//
//  SubmitTableViewCell.swift
//  HafsaInspectorApp
//
//  Created by Junaid Mahmood on 9/28/16.
//  Copyright © 2016 Mahmood. All rights reserved.
//

import UIKit

class SubmitTableViewCell: UITableViewCell {
    
    @IBOutlet weak var submitButton: UIButton!
    
    func configureCell() {
        submitButton.backgroundColor = UIColor.white
        submitButton.tintColor = UIColor.black
        submitButton.titleLabel?.textColor = UIColor.black
        submitButton.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 24)
        submitButton.layer.cornerRadius = 4
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.white.cgColor
    }
    
    @IBAction func submitButtonPressed(_ sender: AnyObject) {
        let vc = self.parentViewController as! FormTableViewController
        vc.submitForm()

    }
}
