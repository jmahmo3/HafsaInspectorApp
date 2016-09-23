//
//  DeviceExtensions.swift
//  HafsaInspectorApp
//
//  Created by Junaid Mahmood on 9/1/16.
//  Copyright © 2016 Mahmood. All rights reserved.
//

import UIKit

public extension UIColor {
    static var HIBackground: UIColor {
        return UIColor(red:0.87, green:0.89, blue:0.75, alpha:1.0)
    }
}

public extension UIViewController {
    func setNavBarWithSettingsIcon(selector:String) {
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        let logo = UIImage(named: "logo")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        let settings = UIImage(named:"cog-16")
        let button = UIBarButtonItem(image: settings, style: .Plain, target: self, action: Selector(selector))
        button.tintColor = UIColor.lightGrayColor()
        self.navigationItem.rightBarButtonItem = button
    }
    
    func setNavBarWithBackButton() {
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        let logo = UIImage(named: "logo")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView

        let settings = UIImage(named:"arrow-80-24")
        let button = UIBarButtonItem(image: settings, style: .Plain, target: self, action:#selector(backButtonPressed))
        button.tintColor = UIColor.blackColor()
        self.navigationItem.leftBarButtonItem = button
    }
    
    func backButtonPressed() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    public var isVisible: Bool {
        if isViewLoaded() {
            return view.window != nil
        }
        return false
    }
    
    public var isTopViewController: Bool {
        if self.navigationController != nil {
            return self.navigationController?.visibleViewController === self
        } else if self.tabBarController != nil {
            return self.tabBarController?.selectedViewController == self && self.presentedViewController == nil
        } else {
            return self.presentedViewController == nil && self.isVisible
        }
    }
    
    var isOnScreen: Bool{
        return self.isViewLoaded() && view.window != nil
    }

    func createAlert(error: String) {
        let alert = UIAlertController(title: "Sorry", message: error, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction((UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:nil)))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func createWebAlertWithTryAgain(error: String, selector:Selector) {
        let alert = UIAlertController(title: "Sorry", message: error, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction((UIAlertAction(title: "Try Again", style: UIAlertActionStyle.Default, handler:{
            (alert: UIAlertAction!) in self.performSelector(selector)
        })))
     

        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}

public extension UIScreen {
    
    enum iPhone {
        case iPhone5
        case iPhone6
        case iPhone6P
    }
    
    static func isiPhone(iphone:iPhone) -> Bool {
        let width: CGFloat = UIScreen.mainScreen().bounds.size.width
        let height: CGFloat = UIScreen.mainScreen().bounds.size.height
        let screenLength: CGFloat = max(width, height)
        
        switch iphone {
        case .iPhone5:
            return screenLength == 568
        case .iPhone6:
            return screenLength == 667
        case .iPhone6P:
            return screenLength == 736
        }
    }
}

public protocol ViewControllerContainer {
    
    var topMostViewController: UIViewController? { get }
}

extension UIViewController: ViewControllerContainer {
    
    public var topMostViewController: UIViewController? {
        
        if let presentedView = presentedViewController {
            
            return recurseViewController(presentedView)
        }
        
        return childViewControllers.last.map(recurseViewController)
    }
}

extension UITabBarController {
    
    public override var topMostViewController: UIViewController? {
        
        return selectedViewController.map(recurseViewController)
    }
}

extension UINavigationController {
    
    public override var topMostViewController: UIViewController? {
        
        return viewControllers.last.map(recurseViewController)
    }
}

extension UIWindow: ViewControllerContainer {
    
    public var topMostViewController: UIViewController? {
        
        return rootViewController.map(recurseViewController)
    }
}

func recurseViewController(viewController: UIViewController) -> UIViewController {
    
    return viewController.topMostViewController.map(recurseViewController) ?? viewController
}






public extension UIWindow {
    public var visibleViewController: UIViewController? {
        return UIWindow.getVisibleViewControllerFrom(self.rootViewController)
    }
    
    public static func getVisibleViewControllerFrom(vc: UIViewController?) -> UIViewController? {
        if let nc = vc as? UINavigationController {
            return UIWindow.getVisibleViewControllerFrom(nc.visibleViewController)
        } else if let tc = vc as? UITabBarController {
            return UIWindow.getVisibleViewControllerFrom(tc.selectedViewController)
        } else {
            if let pvc = vc?.presentedViewController {
                return UIWindow.getVisibleViewControllerFrom(pvc)
            } else {
                return vc
            }
        }
    }
}

extension UIView {
    public var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.nextResponder()
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
