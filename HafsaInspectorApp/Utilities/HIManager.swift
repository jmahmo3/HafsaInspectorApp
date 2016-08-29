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
    
    var username: String = ""
    var chapter: String = ""
    
    class func sharedClient() -> HIManager {
        return sharedInstance
    }

}
