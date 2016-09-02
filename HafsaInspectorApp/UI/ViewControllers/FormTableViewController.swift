//
//  FormTableViewController.swift
//  HafsaInspectorApp
//
//  Created by Junaid Mahmood on 8/31/16.
//  Copyright © 2016 Mahmood. All rights reserved.
//

import UIKit



class FormTableViewController: UITableViewController, UITextFieldDelegate {
    
    private let HImanager = HIManager.sharedClient()

    static func create() -> FormTableViewController {
        let frameworkBundle = NSBundle.mainBundle()
        let storyboard = UIStoryboard(name: "Main", bundle: frameworkBundle)
        let main = storyboard.instantiateViewControllerWithIdentifier("FormTableViewController") as! FormTableViewController
        return main
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return HImanager.supplierArray.count + 1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.item == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("NameTableViewCell", forIndexPath: indexPath) as! NameTableViewCell
            cell.configureNameCell()
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier("SupplierTableViewCell", forIndexPath: indexPath) as! SupplierTableViewCell
            cell.configureSupplierCell(indexPath.item-1)
            return cell
        }

        // Configure the cell...

    }
    
 
}
