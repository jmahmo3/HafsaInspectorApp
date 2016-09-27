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
    
    class func sharedClient() -> CurrentUser {
        return sharedInstance
    }
    
    func signin(_ user: String, _ completion:@escaping CompletionHandler) {
        ref = FIRDatabase.database().reference()
        
        ref.child("users").observe(.value, with: { (snapshot) in
            // Get user value
            
            let value = snapshot.value as? NSDictionary
            if value != nil {
                let users: NSArray = (value!.allKeys as NSArray)
                let mut: NSMutableArray = users.mutableCopy() as! NSMutableArray
                
                for x in users {
                    mut.add((x as! String).lowercased())
                }
                
                if mut.contains(user.lowercased()) {
                    for x in users {
                        if (x as! String).lowercased().isEqual(user.lowercased()) {
                            let userdict: NSDictionary = value?[x] as! NSDictionary
                            let username = userdict["name"] as! String
                            let admin = userdict["admin"] as! Bool
                            print (username)
                            self.username = username
                            self.adminAccess = admin
                            completion(self, nil)
                            DispatchQueue.main.async {
                                UserDefaults.standard.setValue(value, forKey: "userInfo")
                                UserDefaults.standard.setValue(username, forKey: "userName")
                                UserDefaults.standard.set(admin, forKey: "isAdmin")
                            }
                            
                        }
                    }
                }
                else {
                    let err = NSError(domain: "Could not retrieve user", code: 401, userInfo: nil)
                    completion(nil, err)

                }
            }
            
            
        }) { (error) in
            completion(nil, error as NSError?)
            print(error.localizedDescription)
        }

        
    }
    
}
