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
    
     var userName: String = {
        let user = NSUserDefaults.standardUserDefaults().stringForKey("userName")
        if user != nil { return user! }
        else{ return ""}
    }()
    
     var currentChapter: String = {
        let chapter = NSUserDefaults.standardUserDefaults().stringForKey("currentChapter")
        if chapter != nil { return chapter! }
        else { return "" }
    }()
    
    lazy var currentEstablishment: String = ""
    
    var data = []
    
    //Data
    var chapterArray = ["","Chicago", "Detroit", "San Francisco"]
    
    var establishmentArray = ["","Mr. Broast (Lombard)", "Mr. Broast (Aurora)", "Mr. Broast (Morton Grove)", "Main Stop", "Madinah Market", "Pizza Track", "Jerusalem Cafe", "Al Wahid", "Desi Grill", "Portos Peri Peri (Skokie)", "Portos Peri Peri (Schaumburg)", "Tandoor Express", "Makkah Mart", "Hiba Traders", "IDOF (Jackson)", "IDOF (Monroe)", "IDOF (Belmont)", "IDOF (Oakbrook Terrace)", "Al Hijra Grocers", "Marhaba Foods", "Organi Soul", "BBQ Tonight"]
    
    var supplierArray = ["Zabiha Halal Meat Processors/Fatima", "Madinah Trading (Crescent)", "Halal Farms USA", "Hiba Traders", "Miscellaneous"]
    
       
    class func sharedClient() -> HIManager {
        return sharedInstance
    }
    
    

    
    
    
}
