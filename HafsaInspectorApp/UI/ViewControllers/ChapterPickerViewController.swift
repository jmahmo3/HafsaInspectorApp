//
//  ChapterPickerViewController.swift
//  HafsaInspectorApp
//
//  Created by Junaid Mahmood on 8/29/16.
//  Copyright © 2016 Mahmood. All rights reserved.
//

import UIKit
import MBProgressHUD


protocol ChapterPickerDelegate {
    func didChangeChapter()
}

class ChapterPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var chapterTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var chapterLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var chapterData: [String] = [String]()
    private let HImanager = HIManager.sharedClient()
    let picker: UIPickerView = UIPickerView()
    var delegate: ChapterPickerDelegate! = nil
    

    //MARK: - Lifecycle
    @IBOutlet weak var nameLabelToTopConstraint: NSLayoutConstraint!
    
    static func create() -> ChapterPickerViewController {
        let frameworkBundle = NSBundle.mainBundle()
        let storyboard = UIStoryboard(name: "Main", bundle: frameworkBundle)
        let main = storyboard.instantiateViewControllerWithIdentifier("ChapterPickerViewController") as! ChapterPickerViewController
        return main
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    //MARK: Utils
    func setupView(){
        
        if UIScreen.isiPhone(.iPhone5) {
            self.nameLabelToTopConstraint.constant = 150
        }
        
        let firstUse = NSUserDefaults.standardUserDefaults().boolForKey("firstUse")
        if firstUse {
            self.imageView.hidden = true
            self.nextButton.hidden = true
            let settings = UIImage(named:"arrow-80-24")
            let button = UIBarButtonItem(image: settings, style: .Plain, target: self, action: #selector(backButtonPressed))
            button.tintColor = UIColor.blackColor()
            //lightGrayColor()
            self.navigationItem.leftBarButtonItem = button
            nameTextField.text = HImanager.userName
            chapterTextField.text = HImanager.currentChapter

        }
        
        self.hideKeyboardWhenTappedAround()
        
        nameTextField.delegate = self
        chapterTextField.delegate = self
        nameTextField.font = UIFont(name: "AvenirNext-Medium", size: 24)
        chapterTextField.font = UIFont(name: "AvenirNext-Medium", size: 24)
        
        view.backgroundColor = UIColor.HIBackground
        nameLabel.font = UIFont(name: "Avenir-Medium", size: 24)
        chapterLabel.font = UIFont(name: "Avenir-Medium", size: 24)
        nextButton.backgroundColor = UIColor.whiteColor()
        nextButton.tintColor = UIColor.blackColor()
        nextButton.titleLabel?.textColor = UIColor.blackColor()
        nextButton.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 24)
        nextButton.layer.cornerRadius = 4
        nextButton.layer.borderWidth = 1
        nextButton.layer.borderColor = UIColor.whiteColor().CGColor
        
        
        let height: CGFloat = UIScreen.isiPhone(.iPhone5) ? 220 : 253
        picker.frame = CGRectMake(0, 0, self.view.frame.size.width, height)
        picker.delegate = self
        picker.dataSource = self
        chapterTextField.inputView = picker
        
        //Add done button
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)

        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(self.donePicker))
        
        toolBar.setItems([flexSpace,doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        chapterTextField.inputAccessoryView = toolBar
        
        // Input data into the Array:
        chapterData = HImanager.chapterArray
        
        //let loadingNotification = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        //loadingNotification.mode = MBProgressHUDMode.Indeterminate
    }
    
    func createAlert(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    //MARK: - Picker
    func donePicker() {
        let selectedValue = HImanager.chapterArray[picker.selectedRowInComponent(0)]
        chapterTextField.text = selectedValue
        chapterTextField.resignFirstResponder()
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
        let selectedValue = HImanager.chapterArray[picker.selectedRowInComponent(0)]
        chapterTextField.text = selectedValue
    }
    
    
    //MARK: TextFieldShouldReturn
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
    }
    
    //MARK: Actions
    @IBAction func nextButtonPressed(sender: AnyObject) {
      self.saveData()
    }
    
    func backButtonPressed() {
        self.saveData()
        self.delegate.didChangeChapter()
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func saveData() {
        if nameTextField.text!.isEmpty {
            createAlert("Please Enter a Name")
        }
        else {
            //set name
            NSUserDefaults.standardUserDefaults().setValue(nameTextField.text!, forKey: "userName")
            HImanager.userName = nameTextField.text!
            
            //set chapter
            let selectedValue = HImanager.chapterArray[picker.selectedRowInComponent(0)]
            NSUserDefaults.standardUserDefaults().setValue(selectedValue, forKey: "currentChapter")
            HImanager.currentChapter = selectedValue
            
            //TODO: segue
            //           let vc = EstablishmentPickerViewController.create()
            //            AppDelegate().switchRootViewController(vc, animated: false, completion:{})
            
        }

    }

}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}


