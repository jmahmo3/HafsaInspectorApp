//
//  NameTableViewCell.swift
//  HafsaInspectorApp
//
//  Created by Junaid Mahmood on 8/31/16.
//  Copyright © 2016 Mahmood. All rights reserved.
//

import UIKit

// MARK: - NameTableViewCell: UITableViewCell
class NameTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var chapterLabel: UILabel!
    @IBOutlet weak var establishmentLabel: UILabel!
    @IBOutlet weak var datelabel: UILabel!
    
    private let HImanager = HIManager.sharedClient()

    func configureNameCell() {
        
        self.backgroundColor = UIColor.clearColor()
        
        nameLabel.text = HImanager.userName
        chapterLabel.text = HImanager.currentChapter
        establishmentLabel.text = HImanager.currentEstablishment
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM/dd/yy"
        let dateString = formatter.stringFromDate(NSDate())
        datelabel.text = dateString
        
        
        nameLabel.font = UIFont(name: "AvenirNext-Medium", size: 16)
        nameLabel.textColor = UIColor.darkGrayColor()
        establishmentLabel.font = UIFont(name: "AvenirNext-Medium", size: 16)
        establishmentLabel.textColor = UIColor.darkGrayColor()
        chapterLabel.font = UIFont(name: "AvenirNext-Medium", size: 16)
        chapterLabel.textColor = UIColor.darkGrayColor()
        datelabel.font = UIFont(name: "AvenirNext-Medium", size: 16)
        datelabel.textColor = UIColor.darkGrayColor()
    }
}
