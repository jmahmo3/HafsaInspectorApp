//
//  FormTableViewController.swift
//  HafsaInspectorApp
//
//  Created by Junaid Mahmood on 8/31/16.
//  Copyright © 2016 Mahmood. All rights reserved.
//

import UIKit



class FormTableViewController: UITableViewController, UITextViewDelegate {
    
    
    fileprivate let HImanager = HIManager.sharedClient()

    static func create() -> FormTableViewController {
        let frameworkBundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: frameworkBundle)
        let main = storyboard.instantiateViewController(withIdentifier: "FormTableViewController") as! FormTableViewController
        return main
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.HIBackground
        self.setNavBarWithBackButton()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return HImanager.supplierArray.count + 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NameTableViewCell", for: indexPath) as! NameTableViewCell
            cell.configureNameCell()
            return cell
        }
        if indexPath.row > 0 && indexPath.row <= HImanager.supplierArray.count{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SupplierTableViewCell", for: indexPath) as! SupplierTableViewCell
            cell.configureSupplierCell(indexPath.row-1)
            return cell
        }
        if indexPath.row == HImanager.supplierArray.count+1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell", for: indexPath) as! ImageTableViewCell
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell", for: indexPath) as! CommentTableViewCell
            cell.configureCommentTableViewCell()
            cell.textView.delegate = self
            return cell
            
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
