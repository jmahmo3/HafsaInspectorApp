//
//  WebViewViewController.swift
//  HafsaInspectorApp
//
//  Created by Sameer Siddiqui on 9/27/16.
//  Copyright © 2016 Mahmood. All rights reserved.
//

import UIKit
import MBProgressHUD

class WebViewViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    var url: String = ""
    var progess = MBProgressHUD()

    
    static func create(_ url: String) -> WebViewViewController {
        let frameworkBundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: frameworkBundle)
        let main = storyboard.instantiateViewController(withIdentifier: "WebViewViewController") as! WebViewViewController
        main.url = url
        return main
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let open : NSURL! = NSURL(string: url)
        webView.loadRequest(NSURLRequest(url: open as URL) as URLRequest)
        self.setNavBarWithBackButton()
        self.webView.delegate = self
        // Do any additional setup after loading the view.
    }

    func webViewDidStartLoad(_ webView: UIWebView) {
        let progess = MBProgressHUD()
        progess.label.text = "Loading"
        progess.tintColor = UIColor.black
        self.view.addSubview(progess)
        progess.center = self.view.center
        DispatchQueue.main.async {
            self.progess.show(animated: true)
        }
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        DispatchQueue.main.async {
            self.progess.hide(animated: true)
        }
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        let alert = UIAlertController(title:"Sorry", message: "Could not load\nPlease try again", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction((UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{
            (alert: UIAlertAction!) in
            DispatchQueue.main.async {
                _ = self.navigationController?.popViewController(animated: true)
            }
        })))

    }

}
