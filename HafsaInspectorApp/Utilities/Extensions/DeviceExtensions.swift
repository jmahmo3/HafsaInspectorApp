//
//  DeviceExtensions.swift
//  HafsaInspectorApp
//
//  Created by Junaid Mahmood on 9/1/16.
//  Copyright © 2016 Mahmood. All rights reserved.
//

import UIKit

public extension UIColor {
    static var HIBackground: UIColor {
        return UIColor(red:0.87, green:0.89, blue:0.75, alpha:1.0)
    }
}

public extension UIViewController {
    func setNavBarWithSettingsIcon(selector:String) {
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        let logo = UIImage(named: "logo")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        let settings = UIImage(named:"cog-16")
        let button = UIBarButtonItem(image: settings, style: .Plain, target: self, action: Selector(selector))
        button.tintColor = UIColor.lightGrayColor()
        self.navigationItem.rightBarButtonItem = button
    }
    
    func setNavBarWithBackButton() {
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        let logo = UIImage(named: "logo")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView

        let settings = UIImage(named:"arrow-80-24")
        let button = UIBarButtonItem(image: settings, style: .Plain, target: self, action:#selector(backButtonPressed))
        button.tintColor = UIColor.blackColor()
        self.navigationItem.leftBarButtonItem = button

    }
    
//    func setNavBarWithBackButton() {
//        self.setNavBarWithBackButton("backButtonPressed")
//    }
    
    func backButtonPressed() {
        self.navigationController?.popViewControllerAnimated(true)
    }

//    func settingsButtonPressed(vc: UIViewController) {
//        let vc = ChapterPickerViewController.create()
//        vc.delegate = vc
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
}

public extension UIScreen {
    
    enum iPhone {
        case iPhone5
        case iPhone6
        case iPhone6P
    }
    
    static func isiPhone(iphone:iPhone) -> Bool {
        let width: CGFloat = UIScreen.mainScreen().bounds.size.width
        let height: CGFloat = UIScreen.mainScreen().bounds.size.height
        let screenLength: CGFloat = max(width, height)
        
        switch iphone {
        case .iPhone5:
            return screenLength == 568
        case .iPhone6:
            return screenLength == 667
        case .iPhone6P:
            return screenLength == 736
        }
    }
}
