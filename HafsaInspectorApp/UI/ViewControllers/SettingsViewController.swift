//
//  SettingsViewController.swift
//  HafsaInspectorApp
//
//  Created by Sameer Siddiqui on 9/26/16.
//  Copyright © 2016 Mahmood. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var isAdmin: Bool = false
    var isFromAdmin: Bool = false
    
    static func create(_ admin: Bool) -> SettingsViewController {
        let frameworkBundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: frameworkBundle)
        let main = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        main.isFromAdmin = admin
        return main
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        // Do any additional setup after loading the view.
        self.isAdmin = UserDefaults.standard.bool(forKey: "isAdmin")
        self.setNavBarWithBackButton()
        self.tableView.backgroundColor = UIColor.HIBackground

    }

    
    // MARK: - Table view data source
    
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        // #warning Incomplete implementation, return the number of rows
        return self.isAdmin ? 2 : 1
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        if isFromAdmin {
            if indexPath.row == 1{
                cell.textLabel?.text = "Create new user"
                
            }
            else {
                cell.textLabel?.text = "View uploads"
            }
        }
        else {
            if self.isAdmin && indexPath.row == 1{
                cell.textLabel?.text = "Admin tools"
                
            }
            else {
                cell.textLabel?.text = "Change chapter"
                
            } 
        }
        
        
        
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.font = UIFont(name: "AvenirNext-Medium", size: 16)
        cell.selectionStyle = .none

        return cell
        
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if !isFromAdmin {
            switch indexPath.row {
            case 0:
                let vc = ChapterPickerViewController.create()
                self.navigationController?.pushViewController(vc, animated: true)
            case 1:
                let vc = SettingsViewController.create(true)
                self.navigationController?.pushViewController(vc, animated: true)
            default: break
                
            }
        }
        else {
            switch indexPath.row {
            case 0:
                let vc = ChapterPickerViewController.create()
                self.navigationController?.pushViewController(vc, animated: true)
            case 1:
                let vc = CreateUserViewController.create()
                self.navigationController?.pushViewController(vc, animated: true)
            default: break
            }
        }
    }

    
}
