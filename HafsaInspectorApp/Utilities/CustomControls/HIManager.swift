//
//  HIManager.swift
//  HafsaInspectorApp
//
//  Created by Junaid Mahmood on 8/29/16.
//  Copyright © 2016 Mahmood. All rights reserved.
//

import UIKit

class HIManager: NSObject {
    
    fileprivate static var sharedInstance = HIManager()
    
    class func sharedClient() -> HIManager {
        return sharedInstance
    }
    
     var userName: String = {
        let user = UserDefaults.standard.string(forKey: "userName")
        if user != nil { return user! }
        else{ return ""}
    }()
    
     var currentChapter: String = {
        let chapter = UserDefaults.standard.string(forKey: "currentChapter")
        if chapter != nil { return chapter! }
        else { return "" }
    }()
    
    var currentDate: String = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yy"
        let dateString = formatter.string(from: Date())
        return dateString
    }()
    
    var currentEstablishment: String = {
        let chapter = UserDefaults.standard.string(forKey: "currentEstablishment")
        if chapter != nil { return chapter! }
        else { return "" }
    }()
    
    lazy var comments: String = ""

    var data: NSMutableArray = []
    
    var chaptersData: NSDictionary = [:]
    
    var chapters: NSMutableArray = []
    
    var images: NSMutableArray = []
    
    var supplierValues: NSMutableArray = []
    
    var password: String = "halal"
    
    //Dummy Data
    var chapterArray = ["","Chicago", "Detroit", "San Francisco"]
    
    var establishmentArray = ["","Mr. Broast (Lombard)", "Mr. Broast (Aurora)", "Mr. Broast (Morton Grove)", "Main Stop", "Madinah Market", "Pizza Track", "Jerusalem Cafe", "Al Wahid", "Desi Grill", "Portos Peri Peri (Skokie)", "Portos Peri Peri (Schaumburg)", "Tandoor Express", "Makkah Mart", "Hiba Traders", "IDOF (Jackson)", "IDOF (Monroe)", "IDOF (Belmont)", "IDOF (Oakbrook Terrace)", "Al Hijra Grocers", "Marhaba Foods", "Organi Soul", "BBQ Tonight"]
    
    var supplierArray = ["Zabiha Halal Meat Processors/Fatima", "Madinah Trading (Crescent)", "Halal Farms USA", "Hiba Traders", "Miscellaneous"]
    
    
}
