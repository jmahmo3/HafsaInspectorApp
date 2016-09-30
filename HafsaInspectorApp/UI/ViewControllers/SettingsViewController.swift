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

protocol settingsDelegate {
    func backBeingPressed()
}

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var progess = MBProgressHUD()
    var type: SettingsType = .Settings
    var isAdmin: Bool = false
    var isFromAdmin: Bool = false
    var selectedChapter: NSString = " "
    var filedata: NSDictionary = [:]
    var delegate: settingsDelegate! = nil
    var filedataArr: NSMutableArray = []


    
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
    
    override func backButtonPressed() {
        if type == .Settings {
            self.delegate.backBeingPressed()
        }
        _ = self.navigationController?.popViewController(animated: true)

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
            return filedataArr.count
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
            
            let childDict: NSDictionary = filedataArr.reversed()[indexPath.row] as! NSDictionary
            let timestamp = childDict.object(forKey: "timestamp") as! String
            let formatter = DateFormatter()
            formatter.calendar = Calendar(identifier: .iso8601)
            
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
            let date = formatter.date(from: timestamp)
            formatter.dateFormat = "MMM dd, yyyy hh:mm a"
            let keyDate = formatter.string(from: date!)
            
            
            cell.textLabel?.text = childDict.object(forKey: "filename") as! String?
            cell.detailTextLabel?.text = keyDate
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
            let childDict: NSDictionary = filedataArr.reversed()[indexPath.row] as! NSDictionary
            let key = childDict.object(forKey: "imageURL") as! String
            let starsRef = storageRef.child("\(self.selectedChapter)/\(key)")

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
        ref.child("metadata").child(self.selectedChapter as String).queryOrdered(byChild: "timestamp").observe(.childAdded, with: { (snapshot) in
            // Get user value
            
            
            
            let value = snapshot.value as? NSDictionary
            if value == nil {
                DispatchQueue.main.async {
                    self.progess.hide(animated: true)
                }
                self.createAlert("Could not load data\nPlease try again")
            }
            else {
                
                
//                let arr : NSMutableArray = []
//                arr.add(value!)
                
                self.filedataArr.add(value!)
//                let t:OrderedDictionary = OrderedDictionary(dictionary:(snapshot.value as? NSDictionary)!)
//                print(t)
//                
//                
//                
////                let mut: OrderedDictionary = [:]
//                let mutArr: NSMutableArray = []
//                
//                var i = 0
//                while i < value!.count {
////                    let dict: NSDictionary = value!.allValues[i] as! NSDictionary
////                    mut.insert(dict.allValues[0], forKey: dict.allKeys[0], at: UInt(i))
//                    mutArr.add(value!.allValues[i])
//                    print(mutArr.count)
//                    i += 1
//                }
//
//                let datesArr: NSMutableArray = []
//                for dict in mutArr {
//                    let dictionary: NSMutableDictionary = dict as! NSMutableDictionary
//                    let key = dictionary.allKeys[0] as! String
//                    let dateformatter = DateFormatter()
//                    dateformatter.dateFormat = "MM-dd-yyyy_HH_mm_ss"
//                    let date = dateformatter.date(from: key)
//                    let valueForDate: String = dictionary.allValues[0] as! String
//                    let dict: NSDictionary = [date:valueForDate]
//                    datesArr.add(dict)
//                }
//                
//                let keyDatesArr: NSMutableArray = []
//                for dict in datesArr {
//                    let dictionary: NSDictionary = dict as! NSDictionary
//                    let key = dictionary.allKeys[0] as! Date
//                    keyDatesArr.add(key)
//                }
//                let date = NSDate()
//                let sortedArr = keyDatesArr.sortedArray(using: #selector(date.compare))//keyDatesArr.sort({ $0.date.compare($1.date) == ComparisonResult.orderedAscending })
//                print(sortedArr)
//
//                
//                
//                let orderedDictionary: OrderedDictionary = [:]
//                
//                for dict in mutArr {
//                    let dictionary: NSMutableDictionary = dict as! NSMutableDictionary
//                    for key in sortedArr {
//                        let dateformatter = DateFormatter()
//                        dateformatter.dateFormat = "MM-dd-yyyy_HH_mm_ss"
//                        let date = dateformatter.string(from: key as! Date)
//                        if (dictionary.allKeys[0] as! NSString).contains(date) {
//                            orderedDictionary.setValue(dictionary.allValues[0], forKey: date)
//                        }
//                    }
//
//                }
//                
//                
////                for index in 0...sortedArr.count {
////                    for dict in mutArr {
////                        let dictionary: NSDictionary = dict as! NSDictionary
////                        let key: NSDate = sortedArr[index] as! NSDate
////                        let dateformatter = DateFormatter()
////                        dateformatter.dateFormat = "MM-dd-yyyy_HH_mm_ss"
////                        let date = dateformatter.string(from: key as Date)
////                        orderedDictionary.setValue(dictionary.object(forKey: date), forKey: date)
////                    }
////                }
                
                
                
                
//                let sortedArray = value!.sort//sort(value!, {$0.0 < $1.0})
//                print(sortedArray)
//                
//                let keys = sortedArray.map {return $0.0 }
//                print(keys)
//                
//                let values = sortedArray.map {return $0.1 }
//                print(values)
//
                
//                let sorted = value!.keysSortedByValue(comparator: { (obj1, obj2) -> ComparisonResult in
//                    let dateformatter = DateFormatter()
//                    dateformatter.dateFormat = "HH.mm yyyy-MM-dd"
//                    let x = obj1 as! String
//                    let y = obj2 as! String
//                    let x1 = dateformatter.date(from: x)
//                    let y1 = dateformatter.date(from: y)
//
//
//                    return x1!.compare(y1!)
//                })
                
//                print(sorted)
//                self.filedata = value!

                DispatchQueue.main.async {
                    self.tableView.reloadData()

                    self.progess.hide(animated: true)
                }
            }
            
        }) { (error) in
            DispatchQueue.main.async {
                
                self.progess.hide(animated: true)
            }
            self.createAlert("Could not load data\nPlease try again")
            print(error.localizedDescription)
        }

    }
    
    func convertFormatOfDate(date: String, originalFormat: String, destinationFormat: String) -> String! {
        
        
        
        // Orginal format :
        
        let dateOriginalFormat = DateFormatter()
        
        dateOriginalFormat.dateFormat = originalFormat      // in the example it'll take "yy MM dd" (from our call)
        
        
        
        // Destination format :
        
        let dateDestinationFormat = DateFormatter()
        
        dateDestinationFormat.dateFormat = destinationFormat // in the example it'll take "EEEE dd MMMM yyyy" (from our call)
        
        
        
        // Convert current String Date to NSDate
        
        let dateFromString = dateOriginalFormat.date(from: date)
        
        
        
        // Convert new NSDate created above to String with the good format
        
        let dateFormated = dateDestinationFormat.string(from: dateFromString!)
        
        
        
        return dateFormated
        
        
        
    }
    
}
