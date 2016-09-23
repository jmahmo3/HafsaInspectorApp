//
//  HITextField.swift
//  HafsaInspectorApp
//
//  Created by Sameer Siddiqui on 9/2/16.
//  Copyright © 2016 Mahmood. All rights reserved.
//

import UIKit
//import Material

enum HITextFieldType {
    case standard
    case chapterPicker
    case establishmentPicker
}


class HITextField: TextField, UIPickerViewDelegate, UIPickerViewDataSource {

    var data: NSArray = []
    fileprivate let HImanager = HIManager.sharedClient()
    let picker: UIPickerView = UIPickerView()
//    var delegate: ChapterPickerDelegate! = nil
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    func setup(){
        self.dividerHeight = 2.0
        self.dividerColor = UIColor.black
        self.font = UIFont(name: "AvenirNext-Medium", size: 24)
        self.dividerActiveColor = UIColor(red: 57/255, green: 155/255, blue: 82/255, alpha: 1)
        self.placeholderActiveColor = UIColor(red: 57/255, green: 155/255, blue: 82/255, alpha: 1)
    }
    
    func setupPicker() {
        let height: CGFloat = UIScreen.isiPhone(.iPhone5) ? 220 : 253
        picker.frame = CGRect(x: 0, y: 0,width: UIScreen.main.bounds.size.width, height: height)
        picker.delegate = self
        picker.dataSource = self
        self.inputView = picker
        
        //Add done button
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.donePicker))
        toolBar.setItems([flexSpace,doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        self.inputAccessoryView = toolBar
        
    }
    
    func setupChapterPicker() {
        let arr = HImanager.data
        let chapterArr: NSMutableArray = []
        for dict in arr {
            let title = (dict as AnyObject).allKeys[0]
            chapterArr.add(title)
        }
        data = chapterArr.copy() as! [NSArray] as NSArray
        self.setupPicker()
    }
    
    func setupEstablishmentPicker() {
        
        let arr = HImanager.data
        let establishments: NSMutableArray = []
        for dict in arr {
            let title = (dict as AnyObject).allKeys[0]
            if title as! String == HImanager.currentChapter {
                print((dict as AnyObject).object(forKey: title)!)
                establishments.add((dict as AnyObject).object(forKey: title)!)
            }
        }
        if establishments != [] {
            let est: NSArray = establishments.object(at: 0) as! NSArray
            data = est
        }
        else {
            data = []
        }
        self.setupPicker()
    }
    
    //MARK: - Picker
    func donePicker() {
        if data.count > 0 {
            let selectedValue = data[picker.selectedRow(inComponent: 0)]
            self.text = selectedValue as? String
        }
        self.resignFirstResponder()
    }
    
    // The number of columns of data
    func numberOfComponents(in chapterPickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ chapterPickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ chapterPickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let value = data.object(at: row)
        return value as? String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if data.count > 0 {
            let selectedValue = data[picker.selectedRow(inComponent: 0)]
            self.text = selectedValue as? String
        }
    }
}
