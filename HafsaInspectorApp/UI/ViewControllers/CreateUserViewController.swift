//
//  CreateUserViewController.swift
//  HafsaInspectorApp
//
//  Created by Sameer Siddiqui on 9/26/16.
//  Copyright © 2016 Mahmood. All rights reserved.
//

import UIKit
import Firebase

class CreateUserViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var admin: UISwitch!
    @IBOutlet weak var fullname: HITextField!
    @IBOutlet weak var username: HITextField!
    
    @IBOutlet weak var chapterPicker: HITextField!
    
    static func create() -> CreateUserViewController {
        let frameworkBundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: frameworkBundle)
        let main = storyboard.instantiateViewController(withIdentifier: "CreateUserViewController") as! CreateUserViewController
        return main
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.HIBackground
        self.setNavBarWithBackButton()
        self.hideKeyboardWhenTappedAround()
        
        createButton.backgroundColor = UIColor.white
        createButton.tintColor = UIColor.black
        createButton.titleLabel?.textColor = UIColor.black
        createButton.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 24)
        createButton.layer.cornerRadius = 4
        createButton.layer.borderWidth = 1
        createButton.layer.borderColor = UIColor.white.cgColor
        
        username.delegate = self
        fullname.delegate = self
        
        username.placeholder = "Username"
        fullname.placeholder = "Full Name"
        
        chapterPicker.delegate = self
        
        chapterPicker.placeholder = "Select Chapter to set Admin"
        chapterPicker.setupChapterPicker()
        chapterPicker.alpha = 0
        chapterPicker.isHidden = true

        username.autocorrectionType = .no
        fullname.autocorrectionType = .no
        
        self.admin.addTarget(self, action:#selector(switchChanged) , for: .valueChanged)
        
    }
    
    func switchChanged() {
        DispatchQueue.main.async {
            
            UIView.animate(withDuration: 0.3, delay: 0.0, options: [], animations: { () -> Void in
                if self.admin.isOn {
                    self.chapterPicker.alpha = 1
                    self.chapterPicker.isHidden = false
                }
                else {
                    self.chapterPicker.alpha = 0
                    self.chapterPicker.isHidden = true
                }
                }, completion: { (finished: Bool) -> Void in
            })
        }
        
    }


    @IBAction func createButtonPressed(_ sender: AnyObject) {
        let ref: FIRDatabaseReference =  FIRDatabase.database().reference()

        if username.text!.isEmpty  {
            createAlert("Please Enter a Username")
        }
        else if fullname.text!.isEmpty{
            createAlert("Please Enter a Password")
        }
        if !username.text!.isEmpty && !fullname.text!.isEmpty {
            let adminvalue = self.admin.isOn ? 1 : 0
            var chapterAdmin = ""
            if adminvalue == 1 {
                if chapterPicker.text!.isEmpty {
                    createAlert("Please select a chapter the user is an admin of")
                }
                else {
                    let chapter = chapterPicker.text!.replacingOccurrences(of: " ", with: "").lowercased()
                    chapterAdmin = "\(chapter)ChapterAdmin"
                }
            }
            var dict: NSDictionary = [:]
            if adminvalue == 1 {
                dict = ["admin":"\(adminvalue)", chapterAdmin:"1", "name":fullname.text!]
            }
            else {
                dict = ["admin":"\(adminvalue)", "name":fullname.text!]
            }
            ref.child("users").child(username.text!).setValue(dict, withCompletionBlock: { (error, ref) in
                if !(error != nil) {
                    let alert = UIAlertController(title:"", message: "User created Successfully", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction((UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{
                        (alert: UIAlertAction!) in
                        DispatchQueue.main.async {
                            _ = self.navigationController?.popViewController(animated: true)
                        }
                    })))
                    self.present(alert, animated: true, completion: nil)
                }
                else {
                    self.createAlert("Could not create user\nPlease try again")
                }
            })
        }
    }
    
    //MARK: TextFieldShouldReturn
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    

}
