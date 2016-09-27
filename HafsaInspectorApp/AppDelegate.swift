//
//  AppDelegate.swift
//  HafsaInspectorApp
//
//  Created by Junaid Mahmood on 8/29/16.
//  Copyright © 2016 Mahmood. All rights reserved.
//

import UIKit
import MBProgressHUD
import Firebase


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var vc = EstablishmentPickerViewController.create()
    var errorCount = 0
    var ref: FIRDatabaseReference!



    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Usually this is not overridden. Using the "did finish launching" method is more typical
        return true
    }
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let registered = UserDefaults.standard.bool(forKey: "Registered")
        let firstUseDone = UserDefaults.standard.bool(forKey: "FirstUseDone")

        if registered && firstUseDone {
            let nav = UINavigationController.init(rootViewController: vc)
            self.window?.rootViewController? = nav
        }
        else if registered && !firstUseDone {
            let vc = ChapterPickerViewController.create()
            self.window?.rootViewController? = vc
        }
        
        //Firebase
        FIRApp.configure()
        FIRDatabase.database().persistenceEnabled = true
        self.getData()
        
       
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    func getData() {
        let progess = MBProgressHUD()
        let view = (self.window?.rootViewController!.view)!
        progess.label.text = "Retrieving Chapter Data"
        progess.tintColor = UIColor.black
        view.addSubview(progess)
        progess.center = view.center
        progess.show(animated: true)
        WebService().getChaptersAndEstablishmentsFromDatabase{ (success, error) in
            progess.hide(animated: true)
            if success! {
//                print(HIManager.sharedClient().data)
                self.vc.didGetEstablishmentData()
                
                let myVC = self.window?.visibleViewController
                if myVC!.isKind(of: ChapterPickerViewController.self) {
                    let chap = myVC as! ChapterPickerViewController
                    chap.didGetChapterData()
                }
            }
            else {
                self.errorCount += 1
                let alert = UIAlertController(title: "Sorry", message:self.errorCount == 3 ? "Could not retrieve data\nPlease contact admin" : "Could not retrieve data", preferredStyle: UIAlertControllerStyle.alert)
                if self.errorCount != 3 {
                    alert.addAction((UIAlertAction(title: "Retry", style: UIAlertActionStyle.default,  handler:{
                        (alert: UIAlertAction!) in self.getData()
                    })))
                }
                
                let myVC = self.window?.visibleViewController
                if myVC!.isKind(of: ChapterPickerViewController.self) {
                    let chap = myVC as! ChapterPickerViewController
                    chap.present(alert, animated: true, completion: nil)
                }
                else if myVC!.isKind(of: EstablishmentPickerViewController.self) {
                    self.vc.present(alert, animated: true, completion: nil)
                }
                
                
                
                
            }
        }

    }


}

