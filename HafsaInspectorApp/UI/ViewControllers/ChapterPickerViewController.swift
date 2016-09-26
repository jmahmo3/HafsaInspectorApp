//
//  ChapterPickerViewController.swift
//  HafsaInspectorApp
//
//  Created by Junaid Mahmood on 8/29/16.
//  Copyright © 2016 Mahmood. All rights reserved.
//

import UIKit
import MBProgressHUD
//import Material
import Firebase


protocol ChapterPickerDelegate {
    func didChangeChapter()
}

class ChapterPickerViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var chapterTextField: HITextField!
    @IBOutlet weak var nameTextField: HITextField!

    
    var chapterData: [String] = [String]()
    fileprivate let HImanager = HIManager.sharedClient()
    let picker: UIPickerView = UIPickerView()
    var delegate: ChapterPickerDelegate! = nil


    //MARK: - Lifecycle
    
    static func create() -> ChapterPickerViewController {
        let frameworkBundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: frameworkBundle)
        let main = storyboard.instantiateViewController(withIdentifier: "ChapterPickerViewController") as! ChapterPickerViewController
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
        
        let firstUse = UserDefaults.standard.bool(forKey: "Registered")
        if firstUse {
            self.setNavBarWithBackButton()
            self.imageView.isHidden = true
            self.nextButton.isHidden = true
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
        
        nextButton.backgroundColor = UIColor.white
        nextButton.tintColor = UIColor.black
        nextButton.titleLabel?.textColor = UIColor.black
        nextButton.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 24)
        nextButton.layer.cornerRadius = 4
        nextButton.layer.borderWidth = 1
        nextButton.layer.borderColor = UIColor.white.cgColor
        
    }
    
    //MARK: TextFieldShouldReturn
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    //MARK: Actions
    @IBAction func nextButtonPressed(_ sender: AnyObject) {
        self.saveData()
    }
    
    override func backButtonPressed() {
        self.saveData()
        self.delegate.didChangeChapter()
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func saveData() {
        if nameTextField.text!.isEmpty  {
            createAlert("Please Enter a Name")
        }
        else if chapterTextField.text!.isEmpty{
            createAlert("Please Select a Chapter")
        }
        else {
            
            UserDefaults.standard.set(true, forKey: "Registered")
            //set name
            UserDefaults.standard.setValue(nameTextField.text!, forKey: "userName")
            HImanager.userName = nameTextField.text!
            
            //set chapter
            let selectedValue = chapterTextField.text!
            UserDefaults.standard.setValue(selectedValue, forKey: "currentChapter")
            HImanager.currentChapter = selectedValue
            
        }
    }
    
 
    
    func didGetChapterData() {
        if self.isOnScreen {
            self.chapterTextField.setupChapterPicker()
        }
    }
}



