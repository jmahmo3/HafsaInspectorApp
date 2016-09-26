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
    
    fileprivate let HImanager = HIManager.sharedClient()

    func configureNameCell() {
        self.selectionStyle = UITableViewCellSelectionStyle.none

        self.backgroundColor = UIColor.clear
        
        nameLabel.text = HImanager.userName
        chapterLabel.text = HImanager.currentChapter
        establishmentLabel.text = HImanager.currentEstablishment
        
        datelabel.text = HImanager.currentDate
        
        
        nameLabel.font = UIFont(name: "AvenirNext-Medium", size: 16)
        nameLabel.textColor = UIColor.darkGray
        establishmentLabel.font = UIFont(name: "AvenirNext-Medium", size: 16)
        establishmentLabel.textColor = UIColor.darkGray
        chapterLabel.font = UIFont(name: "AvenirNext-Medium", size: 16)
        chapterLabel.textColor = UIColor.darkGray
        datelabel.font = UIFont(name: "AvenirNext-Medium", size: 16)
        datelabel.textColor = UIColor.darkGray
    }
}
