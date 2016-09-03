//
//  ChapterPickerViewController.swift
//  HafsaInspectorApp
//
//  Created by Junaid Mahmood on 8/29/16.
//  Copyright © 2016 Mahmood. All rights reserved.
//

import UIKit
import MBProgressHUD
import Material


protocol ChapterPickerDelegate {
    func didChangeChapter()
}

class ChapterPickerViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var chapterTextField: HITextField!
    @IBOutlet weak var nameTextField: HITextField!

    
    var chapterData: [String] = [String]()
    private let HImanager = HIManager.sharedClient()
    let picker: UIPickerView = UIPickerView()
    var delegate: ChapterPickerDelegate! = nil

    //MARK: - Lifecycle
    
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
//            self.nameLabelToTopConstraint.constant = 150
        }
        
        let firstUse = NSUserDefaults.standardUserDefaults().boolForKey("Registered")
        if firstUse {
            self.setNavBarWithBackButton()
            self.imageView.hidden = true
            self.nextButton.hidden = true
            nameTextField.text = HImanager.userName
            chapterTextField.text = HImanager.currentChapter

        }
        
        view.backgroundColor = UIColor.HIBackground
        self.hideKeyboardWhenTappedAround()
        
        nameTextField.delegate = self
        chapterTextField.delegate = self

        nameTextField.placeholder = "Name"
        chapterTextField.placeholder = "Chapter"
        chapterTextField.setupChapterPicker()
        
        nextButton.backgroundColor = UIColor.whiteColor()
        nextButton.tintColor = UIColor.blackColor()
        nextButton.titleLabel?.textColor = UIColor.blackColor()
        nextButton.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 24)
        nextButton.layer.cornerRadius = 4
        nextButton.layer.borderWidth = 1
        nextButton.layer.borderColor = UIColor.whiteColor().CGColor
    }
    
    func createAlert(error: String) {
        let alert = UIAlertController(title: "Sorry", message: error, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction((UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:nil)))
        self.presentViewController(alert, animated: true, completion: nil)
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
    
    override func backButtonPressed() {
        self.saveData()
        self.delegate.didChangeChapter()
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func saveData() {
        if nameTextField.text!.isEmpty  {
            createAlert("Please Enter a Name")
        }
        else if chapterTextField.text!.isEmpty{
            createAlert("Please Select a Chapter")
        }
        else {
            
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "Registered")
            //set name
            NSUserDefaults.standardUserDefaults().setValue(nameTextField.text!, forKey: "userName")
            HImanager.userName = nameTextField.text!
            
            //set chapter
            let selectedValue = chapterTextField.text!
            NSUserDefaults.standardUserDefaults().setValue(selectedValue, forKey: "currentChapter")
            HImanager.currentChapter = selectedValue
            
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


