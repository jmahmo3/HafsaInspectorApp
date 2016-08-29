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
    
    var pickerData: [String] = [String]()
    
    private let HImanager = HIManager.sharedClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Connect data:
        self.chapterPickerView.delegate = self
        self.chapterPickerView.dataSource = self
        
        // Input data into the Array:
        pickerData = ["Chicago", "Detroit", "San Francisco"]
        
        //let loadingNotification = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        //loadingNotification.mode = MBProgressHUDMode.Indeterminate

    }
    // The number of columns of data
    func numberOfComponentsInPickerView(chapterPickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(chapterPickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(chapterPickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
}

