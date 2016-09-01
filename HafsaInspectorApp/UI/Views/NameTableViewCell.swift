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
        nameLabel.text = HImanager.userName
        chapterLabel.text = HImanager.currentChapter
        establishmentLabel.text = HImanager.currentEstablishment
        //datelabel.text = String(NSDate())
    }
}
