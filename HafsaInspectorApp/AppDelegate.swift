//
//  AppDelegate.swift
//  HafsaInspectorApp
//
//  Created by Junaid Mahmood on 8/29/16.
//  Copyright © 2016 Mahmood. All rights reserved.
//

import UIKit
import MBProgressHUD


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var vc = EstablishmentPickerViewController.create()
    var errorCount = 0


    func application(application: UIApplication, willFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Usually this is not overridden. Using the "did finish launching" method is more typical

        let registered = NSUserDefaults.standardUserDefaults().boolForKey("Registered")
        if registered {
            let nav = UINavigationController.init(rootViewController: vc)
            self.window?.rootViewController? = nav

        }
        
        self.getData()
        
        return true
    }
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    func getData() {
        let progess = MBProgressHUD()
        let view = (self.window?.rootViewController!.view)!
        progess.label.text = "Retrieving Chapter Data"
        progess.tintColor = UIColor.blackColor()
        view.addSubview(progess)
        progess.center = view.center
        progess.showAnimated(true)
        WebService().getChaptersAndEstablishments { (success, error) in
            progess.hideAnimated(true)
            if success! {
                print(HIManager.sharedClient().data)
                self.vc.didGetEstablishmentData()
                
                let myVC = self.window?.visibleViewController
                if myVC!.isKindOfClass(ChapterPickerViewController) {
                    let chap = myVC as! ChapterPickerViewController
                    chap.didGetChapterData()
                }
            }
            else {
                self.errorCount += 1
                let alert = UIAlertController(title: "Sorry", message:self.errorCount == 3 ? "Could not retrieve data\nPlease contact admin" : "Could not retrieve data", preferredStyle: UIAlertControllerStyle.Alert)
                if self.errorCount != 3 {
                    alert.addAction((UIAlertAction(title: "Retry", style: UIAlertActionStyle.Default,  handler:{
                        (alert: UIAlertAction!) in self.getData()
                    })))
                }
                
                let myVC = self.window?.visibleViewController
                if myVC!.isKindOfClass(ChapterPickerViewController) {
                    let chap = myVC as! ChapterPickerViewController
                    chap.presentViewController(alert, animated: true, completion: nil)
                }
                else if myVC!.isKindOfClass(EstablishmentPickerViewController) {
                    self.vc.presentViewController(alert, animated: true, completion: nil)
                }
                
                
                
                
            }
        }

    }


}

