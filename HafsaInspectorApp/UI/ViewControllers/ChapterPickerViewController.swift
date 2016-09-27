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
    @IBOutlet weak var chapterTextField: HITextField!

    @IBOutlet weak var chapterLabel: UILabel!
    
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
        let registered = UserDefaults.standard.bool(forKey: "Registered")
        let firstUseDone = UserDefaults.standard.bool(forKey: "FirstUseDone")

        if (registered && !firstUseDone) {
            self.chapterLabel.text = "Hello \(HIManager().userName)\nPlease select a chapter\nYou could change this later"
        }
        else {
            self.chapterLabel.text = "Please edit your chapter"
            self.chapterTextField.text = HImanager.currentChapter
            self.nextButton.isHidden = true
            self.setNavBarWithBackButton()
        }
        
        view.backgroundColor = UIColor.HIBackground
        self.hideKeyboardWhenTappedAround()
        
        chapterTextField.delegate = self

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
        UserDefaults.standard.set(true, forKey: "FirstUseDone")
        self.saveData()
    }
    
    override func backButtonPressed() {
        self.saveData()
//        self.delegate.didChangeChapter()
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func saveData() {
       
         if chapterTextField.text!.isEmpty{
            createAlert("Please Select a Chapter")
        }
        else {
            
            UserDefaults.standard.set(true, forKey: "Registered")
            
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



