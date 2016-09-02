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
