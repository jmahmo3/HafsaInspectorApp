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
    var establishmentArray = ["Mr. Broast (Lombard)", "Mr. Broast (Aurora)", "Mr. Broast (Morton Grove)", "Main Stop", "Madinah Market", "Pizza Track", "Jerusalem Cafe", "Al Wahid", "Desi Grill", "Portos Peri Peri (Skokie)", "Portos Peri Peri (Schaumburg)", "Tandoor Express", "Makkah Mart", "Hiba Traders", "IDOF (Jackson)", "IDOF (Monroe)", "IDOF (Belmont)", "IDOF (Oakbrook Terrace)", "Al Hijra Grocers", "Marhaba Foods", "Organi Soul", "BBQ Tonight"]
    
       
    class func sharedClient() -> HIManager {
        return sharedInstance
    }
    
    

    
    
    
}
