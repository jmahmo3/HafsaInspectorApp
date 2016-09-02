//
//  EstablishmentPickerViewController.swift
//  HafsaInspectorApp
//
//  Created by Junaid Mahmood on 8/31/16.
//  Copyright © 2016 Mahmood. All rights reserved.
//

import UIKit

class EstablishmentPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, ChapterPickerDelegate {
    
    private let HImanager = HIManager.sharedClient()
    let picker: UIPickerView = UIPickerView()

    @IBOutlet weak var establishmentTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var establishmentLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var legitEstablishmentLabel: UILabel!
    
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
        
    }
    
    //MARK: Utils
    func setupView() {
        self.hideKeyboardWhenTappedAround()
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        let logo = UIImage(named: "haa-cropped")
        let imageView = UIImageView(image:logo)
//        imageView.frame = CGRectMake(0, 20, 12, 40)
        self.navigationItem.titleView = imageView
        
        let settings = UIImage(named:"cog-16")
        let button = UIBarButtonItem(image: settings, style: .Plain, target: self, action: #selector(settingsButtonPressed))
        button.tintColor = UIColor.lightGrayColor()
        self.navigationItem.rightBarButtonItem = button
        
        self.picker.delegate = self
        self.picker.dataSource = self
        nameLabel.text = HImanager.userName
        establishmentLabel.text = HImanager.currentChapter
        view.backgroundColor = UIColor(red:0.87, green:0.89, blue:0.75, alpha:1.0)//UIColor(red:0.67, green:0.74, blue:0.24, alpha:1.0)
        
        //font
        nameLabel.font = UIFont(name: "AvenirNext-Medium", size: 20)
        nameLabel.textColor = UIColor.darkGrayColor()
        establishmentLabel.font = UIFont(name: "AvenirNext-Medium", size: 20)
        establishmentLabel.textColor = UIColor.darkGrayColor()
        establishmentTextField.font = UIFont(name: "AvenirNext-Medium", size: 20)
        legitEstablishmentLabel.font = UIFont(name: "AvenirNext-Medium", size: 17)
        legitEstablishmentLabel.sizeToFit()
        
        //button
        nextButton.backgroundColor = UIColor.whiteColor()
        nextButton.tintColor = UIColor.blackColor()
        nextButton.titleLabel?.textColor = UIColor.blackColor()
        nextButton.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 24)
        nextButton.layer.cornerRadius = 4
        nextButton.layer.borderWidth = 1
        nextButton.layer.borderColor = UIColor.whiteColor().CGColor

        picker.frame = CGRectMake(0, 0, self.view.frame.size.width, 253)
        picker.delegate = self
        picker.dataSource = self
        establishmentTextField.inputView = picker
        
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
        establishmentTextField.inputAccessoryView = toolBar

    }
    
    func createAlert(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }


    
    //MARK: - Picker
    func donePicker() {
        let selectedValue = HImanager.establishmentArray[picker.selectedRowInComponent(0)]
        establishmentTextField.text = selectedValue
        establishmentTextField.resignFirstResponder()
    }
    
    // The number of columns of data
    func numberOfComponentsInPickerView(chapterPickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(chapterPickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return HImanager.establishmentArray.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(chapterPickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return HImanager.establishmentArray[row]
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        HImanager.currentEstablishment = HImanager.establishmentArray[row]
        establishmentTextField.text = HImanager.establishmentArray[row]
    }
    
    
    //MARK: Actions
    @IBAction func nextButtonPressed(sender: AnyObject) {
        
        if establishmentTextField.text!.isEmpty {
            self.createAlert("Please choose an establishment")
        }
        else {
            //set establishment
            let selectedValue = HImanager.establishmentArray[picker.selectedRowInComponent(0)]
            HImanager.currentEstablishment = selectedValue
            
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
