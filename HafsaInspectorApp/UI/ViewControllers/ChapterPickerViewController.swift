//
//  ChapterPickerViewController.swift
//  HafsaInspectorApp
//
//  Created by Junaid Mahmood on 8/29/16.
//  Copyright © 2016 Mahmood. All rights reserved.
//

import UIKit
import MBProgressHUD


class ChapterPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var chapterPickerView: UIPickerView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var chapterLabel: UILabel!
    
    var chapterData: [String] = [String]()
    
    private let HImanager = HIManager.sharedClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red:0.67, green:0.74, blue:0.24, alpha:1.0)
        nameLabel.font = UIFont(name: "Avenir-Light", size: 18)
        chapterLabel.font = UIFont(name: "Avenir-Light", size: 18)
    

        // Connect data:
        self.chapterPickerView.delegate = self
        self.chapterPickerView.dataSource = self
        
        // Input data into the Array:
        chapterData = HImanager.chapterArray
        
        //let loadingNotification = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        //loadingNotification.mode = MBProgressHUDMode.Indeterminate

    }
    // The number of columns of data
    func numberOfComponentsInPickerView(chapterPickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(chapterPickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return chapterData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(chapterPickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return chapterData[row]
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        HImanager.currentChapter = chapterData[row]
    }
    
    @IBAction func nextButtonPressed(sender: AnyObject) {
        if nameTextField.text!.isEmpty {
            createAlert("Please Enter a Name")
        }else {
            HImanager.userName = nameTextField.text!
            NSUserDefaults.standardUserDefaults().setValue(HImanager.userName, forKey: "userName")
            NSUserDefaults.standardUserDefaults().setValue(HImanager.currentChapter, forKey: "currentChapter")
        }
    }
    
    func createAlert(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
        self.presentViewController(alert, animated: true, completion: nil)
    }

    
    
}

