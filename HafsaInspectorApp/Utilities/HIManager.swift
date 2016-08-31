//
//  HIManager.swift
//  HafsaInspectorApp
//
//  Created by Junaid Mahmood on 8/29/16.
//  Copyright © 2016 Mahmood. All rights reserved.
//

import UIKit

class HIManager: NSObject {
    
    private static var sharedInstance = HIManager()
    
    lazy var userName: String = {
        return NSUserDefaults.standardUserDefaults().stringForKey("userName")!
    }()
    
    lazy var currentChapter: String = {
        return NSUserDefaults.standardUserDefaults().stringForKey("currentChapter")!
    }()
    lazy var currentEstablishment: String = {
        return NSUserDefaults.standardUserDefaults().stringForKey("currentEstablishment")!
    }()
    
    //PickerView data
    var chapterArray = ["Chicago", "Detroit", "San Francisco"]
    var establishmentArray = []
    
       
    class func sharedClient() -> HIManager {
        return sharedInstance
    }
    
    

    
    
    
}
