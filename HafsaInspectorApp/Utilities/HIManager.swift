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
        if let name =  NSUserDefaults.standardUserDefaults().stringForKey("userName"){
            return name
        }else {
            return ""
        }
    }()
    
    lazy var currentChapter: String = {
        if let chapter = NSUserDefaults.standardUserDefaults().stringForKey("currentChapter") {
            return chapter
        } else{
            return ""
        }
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
