//
//  EstablishmentPickerViewController.swift
//  HafsaInspectorApp
//
//  Created by Junaid Mahmood on 8/31/16.
//  Copyright © 2016 Mahmood. All rights reserved.
//

import UIKit

class EstablishmentPickerViewController: UIViewController, UITextFieldDelegate, ChapterPickerDelegate {
    
    fileprivate let HImanager = HIManager.sharedClient()

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var establishmentLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var establishmentTextField: HITextField!

    //MARK: - Lifecycle

    static func create() -> EstablishmentPickerViewController {
        let frameworkBundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: frameworkBundle)
        let main = storyboard.instantiateViewController(withIdentifier: "EstablishmentPickerViewController") as! EstablishmentPickerViewController
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
        nameLabel.textColor = UIColor.darkGray
        establishmentLabel.font = UIFont(name: "AvenirNext-Medium", size: 16)
        establishmentLabel.textColor = UIColor.darkGray
        
        //button
        nextButton.backgroundColor = UIColor.white
        nextButton.tintColor = UIColor.black
        nextButton.titleLabel?.textColor = UIColor.black
        nextButton.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 24)
        nextButton.layer.cornerRadius = 4
        nextButton.layer.borderWidth = 1
        nextButton.layer.borderColor = UIColor.white.cgColor

        establishmentTextField.placeholder = "Establishment"
        establishmentTextField.setupEstablishmentPicker()
 
    }

    //MARK: Actions
    @IBAction func nextButtonPressed(_ sender: AnyObject) {
        
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
        establishmentTextField.text = ""
        establishmentTextField.setupEstablishmentPicker()

    }

    func didGetEstablishmentData(){
        if establishmentTextField != nil {
            establishmentTextField.setupEstablishmentPicker()
        }
    }
    

}
