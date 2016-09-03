//
//  EstablishmentPickerViewController.swift
//  HafsaInspectorApp
//
//  Created by Junaid Mahmood on 8/31/16.
//  Copyright © 2016 Mahmood. All rights reserved.
//

import UIKit

class EstablishmentPickerViewController: UIViewController, UITextFieldDelegate, ChapterPickerDelegate {
    
    private let HImanager = HIManager.sharedClient()

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var establishmentLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var establishmentTextField: HITextField!

    //MARK: - Lifecycle

    static func create() -> EstablishmentPickerViewController {
        let frameworkBundle = NSBundle.mainBundle()
        let storyboard = UIStoryboard(name: "Main", bundle: frameworkBundle)
        let main = storyboard.instantiateViewControllerWithIdentifier("EstablishmentPickerViewController") as! EstablishmentPickerViewController
        return main
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        
        
        AppDelegate().window?.rootViewController = self.navigationController
        
    }
    
    //MARK: Utils
    func setupView() {
        self.hideKeyboardWhenTappedAround()
        self.setNavBarWithSettingsIcon("settingsButtonPressed")
        nameLabel.text = HImanager.userName
        establishmentLabel.text = HImanager.currentChapter
        view.backgroundColor = UIColor(red:0.87, green:0.89, blue:0.75, alpha:1.0)//UIColor(red:0.67, green:0.74, blue:0.24, alpha:1.0)
        
        //font
        nameLabel.font = UIFont(name: "AvenirNext-Medium", size: 16)
        nameLabel.textColor = UIColor.darkGrayColor()
        establishmentLabel.font = UIFont(name: "AvenirNext-Medium", size: 16)
        establishmentLabel.textColor = UIColor.darkGrayColor()
        
        //button
        nextButton.backgroundColor = UIColor.whiteColor()
        nextButton.tintColor = UIColor.blackColor()
        nextButton.titleLabel?.textColor = UIColor.blackColor()
        nextButton.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 24)
        nextButton.layer.cornerRadius = 4
        nextButton.layer.borderWidth = 1
        nextButton.layer.borderColor = UIColor.whiteColor().CGColor

        establishmentTextField.placeholder = "Establishment"
        establishmentTextField.setupEstablishmentPicker()
 
    }
    
    func createAlert(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    //MARK: Actions
    @IBAction func nextButtonPressed(sender: AnyObject) {
        
        if establishmentTextField.text!.isEmpty {
            self.createAlert("Please choose an establishment")
        }
        else {
            //set establishment
            HImanager.currentEstablishment = establishmentTextField.text!
            //segue
            let vc = FormTableViewController.create()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func settingsButtonPressed() {
        let vc = ChapterPickerViewController.create()
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: ChapterPickerDelegate
    func didChangeChapter() {
        nameLabel.text = HImanager.userName
        establishmentLabel.text = HImanager.currentChapter
    }

}
