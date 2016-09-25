//
//  CommentTableViewCell.swift
//  HafsaInspectorApp
//
//  Created by Junaid Mahmood on 9/6/16.
//  Copyright © 2016 Mahmood. All rights reserved.
//

import UIKit


class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var textView: RPFloatingPlaceholderTextView!
    
    func configureCommentTableViewCell() {
        textView.placeholder = "Comments and Concerns"
        textView.font = UIFont(name: "AvenirNext-Medium", size: 16)
        textView.defaultPlaceholderColor = UIColor.black
        textView.floatingLabelActiveTextColor = UIColor(red: 57/255, green: 155/255, blue: 82/255, alpha: 1)
        textView.floatingLabelInactiveTextColor = UIColor.gray
        textView.floatingLabel.font = UIFont(name: "AvenirNext-Medium", size: 16)
        textView.animationDirection = RPFloatingPlaceholderAnimationOptions.animateUpward
//        self.parentViewController!.hideKeyboardWhenTappedAround()
        self.superview?.parentViewController?.hideKeyboardWhenTappedAround()
    }
   
    
    
}
