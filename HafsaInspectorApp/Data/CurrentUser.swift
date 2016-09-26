//
//  CurrentUser.swift
//  HafsaInspectorApp
//
//  Created by Sameer Siddiqui on 9/25/16.
//  Copyright © 2016 Mahmood. All rights reserved.
//

import UIKit
import Firebase

class CurrentUser: NSObject {
    
    fileprivate static var sharedInstance = CurrentUser()
    typealias CompletionHandler = (CurrentUser?, NSError?) -> Void
    var ref: FIRDatabaseReference!
    var username: String = ""
    var adminAccess: Bool = false
    
    
    override init() {
        super.init()
    }
    
    convenience init(_ username: String) {
        self.init()
//        self.signin(username) { (CurrentUser,?, NSError?) in
//            
//        }
    }
    
    class func sharedClient() -> CurrentUser {
        return sharedInstance
    }
    
    func signin(_ user: String, _ completion:@escaping CompletionHandler) {
        ref = FIRDatabase.database().reference()
        
        ref.child("users").child(user).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let username = value?["name"] as! String
            let admin = value?["admin"] as! Bool
            print (username)
            self.username = username
            self.adminAccess = admin
            completion(self, nil)
            
        }) { (error) in
            completion(nil, error as NSError?)
            print(error.localizedDescription)
        }
        
    }
    
}
