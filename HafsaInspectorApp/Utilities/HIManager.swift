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
    
    var userName: String = ""
    var currentChapter:String = ""
    var currentEstablishment: String = ""
    
    //PickerView data
    var chapterArray = ["Chicago", "Detroit", "San Francisco"]
    var establishmentArray = []
    
       
    class func sharedClient() -> HIManager {
        return sharedInstance
    }
    
    

    
    
    
}
