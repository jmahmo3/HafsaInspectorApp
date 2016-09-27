//
//  SettingsViewController.swift
//  HafsaInspectorApp
//
//  Created by Sameer Siddiqui on 9/26/16.
//  Copyright © 2016 Mahmood. All rights reserved.
//

import UIKit
import Firebase
import MBProgressHUD


enum SettingsType {
    case Admin
    case Settings
    case Chapters
    case ViewFiles
}

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var progess = MBProgressHUD()
    var type: SettingsType = .Settings
    var isAdmin: Bool = false
    var isFromAdmin: Bool = false
    var selectedChapter: NSString = " "
    var filedata: NSDictionary = [:]
    
    static func create(_ type: SettingsType) -> SettingsViewController {
        let frameworkBundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: frameworkBundle)
        let main = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        main.type = type
        return main
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        // Do any additional setup after loading the view.
        self.isAdmin = UserDefaults.standard.bool(forKey: "isAdmin")
        self.setNavBarWithBackButton()
        self.tableView.backgroundColor = UIColor.HIBackground
        
        if type == .ViewFiles {
            self.getData()
        }
        progess.tintColor = UIColor.black
        self.view.addSubview(progess)
        progess.center = self.view.center
        
    }

    // MARK: - Table view data source
    
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if type == .Admin {return 2}
        else if type == .Settings {return self.isAdmin ? 2 : 1}
        else if type == .Chapters {
            return HIManager.sharedClient().chapters.count
        }
        else {
            return filedata.count
        }
        
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if type != .ViewFiles {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
          
            if type == .Admin {
                if indexPath.row == 1{
                    cell.textLabel?.text = "Create new user"
                }
                else {
                    cell.textLabel?.text = "View uploads"
                }
            }
            else if type == .Settings {
                if self.isAdmin && indexPath.row == 1{
                    cell.textLabel?.text = "Admin tools"
                    
                }
                else {
                    cell.textLabel?.text = "Change chapter"
                }
            }
            else if type == .Chapters {
                cell.textLabel?.text = (HIManager.sharedClient().chapters.object(at: indexPath.row) as! NSString) as String
            }
            cell.backgroundColor = UIColor.clear
            cell.textLabel?.font = UIFont(name: "AvenirNext-Medium", size: 16)
            cell.selectionStyle = .none
            
            return cell
            
        }
        else {
            let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell")
            let childID: NSString = (filedata.allKeys[indexPath.row] as! NSString)
            let childDict: NSDictionary = filedata.object(forKey: childID) as! NSDictionary
            let key = childDict.allKeys[0] as! String
            cell.textLabel?.text = childDict.object(forKey: key) as! String?
            cell.detailTextLabel?.text = key
            cell.backgroundColor = UIColor.clear
            cell.textLabel?.font = UIFont(name: "AvenirNext-Medium", size: 16)
            cell.selectionStyle = .none
            
            return cell
        }
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if type == .Settings {
            switch indexPath.row {
            case 0:
                let vc = ChapterPickerViewController.create()
                self.navigationController?.pushViewController(vc, animated: true)
            case 1:
                let vc = SettingsViewController.create(.Admin)
                self.navigationController?.pushViewController(vc, animated: true)
            default: break
                
            }
        }
        else if type == .Admin {
            switch indexPath.row {
            case 0:
                let vc = SettingsViewController.create(.Chapters)
                self.navigationController?.pushViewController(vc, animated: true)
            case 1:
                let vc = CreateUserViewController.create()
                self.navigationController?.pushViewController(vc, animated: true)
            default: break
            }
        }
        else if type == .Chapters {
            let vc = SettingsViewController.create(.ViewFiles)
            vc.selectedChapter = (HIManager.sharedClient().chapters.object(at: indexPath.row) as! String as NSString)
            self.navigationController?.pushViewController(vc, animated: true)

        }
        else if type == .ViewFiles {
            let storage = FIRStorage.storage()
            
            // File located on disk
            let storageRef = storage.reference()
            let childID: NSString = (filedata.allKeys[indexPath.row] as! NSString)
            let childDict: NSDictionary = filedata.object(forKey: childID) as! NSDictionary
            let key = childDict.allKeys[0] as! String
            let starsRef = storageRef.child("\(self.selectedChapter)/\(childDict.object(forKey: key) as! String)")

            // Fetch the download URL
            progess.label.text = "Loading..."
            progess.show(animated: true)
            starsRef.downloadURL { (URL, error) -> Void in
                if (error != nil) {
                    // Handle any errors
                    DispatchQueue.main.async {
                        self.progess.hide(animated: true)
                    }
                    self.createAlert("Could not open file\nPlease try again")
                } else {
                    DispatchQueue.main.async {
                        self.progess.hide(animated: true)
                    }
                    print(URL)
                    let vc = WebViewViewController.create((URL?.absoluteString)!)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            
        }
    }
    
    //MARK: - Utils
    
    func getData(){
        let ref: FIRDatabaseReference =  FIRDatabase.database().reference()
        
        progess.label.text = "Loading..."
        progess.show(animated: true)
        ref.child("metadata").child(self.selectedChapter as String).observe(.value, with: { (snapshot) in
            // Get user value
            
            let value = snapshot.value as? NSDictionary
            self.filedata = value!
                print(value)
            self.tableView.reloadData()
            DispatchQueue.main.async {
                self.progess.hide(animated: true)
            }
        }) { (error) in
            DispatchQueue.main.async {
                
                self.progess.hide(animated: true)
            }
            self.createAlert("Could not load data\nPlease try again")
            print(error.localizedDescription)
        }

    }
    
}
