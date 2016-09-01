//
//  EstablishmentPickerViewController.swift
//  HafsaInspectorApp
//
//  Created by Junaid Mahmood on 8/31/16.
//  Copyright © 2016 Mahmood. All rights reserved.
//

import UIKit

class EstablishmentPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    private let HImanager = HIManager.sharedClient()

    @IBOutlet weak var establishmentPicker: UIPickerView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var establishmentLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        establishmentLabel.font = UIFont(name: "Avenir-Light", size: 18)
        nameLabel.font = UIFont(name: "Avenir-Light", size: 18)
        view.backgroundColor = UIColor(red:0.67, green:0.74, blue:0.24, alpha:1.0)

        // Do any additional setup after loading the view.
        self.establishmentPicker.delegate = self
        self.establishmentPicker.dataSource = self
        
        //TODO: Set Name label with name from HImanager
        nameLabel.text = HImanager.userName
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
    }

    @IBAction func nextButtonPressed(sender: AnyObject) {
        
        //set establishment
        let selectedValue = HImanager.establishmentArray[establishmentPicker.selectedRowInComponent(0)]
        HImanager.currentEstablishment = selectedValue
        
        //segue

    }
    

}
