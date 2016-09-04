//
//  FormTableViewController.swift
//  HafsaInspectorApp
//
//  Created by Junaid Mahmood on 8/31/16.
//  Copyright © 2016 Mahmood. All rights reserved.
//

import UIKit



class FormTableViewController: UITableViewController {
    
    
    private let HImanager = HIManager.sharedClient()

    static func create() -> FormTableViewController {
        let frameworkBundle = NSBundle.mainBundle()
        let storyboard = UIStoryboard(name: "Main", bundle: frameworkBundle)
        let main = storyboard.instantiateViewControllerWithIdentifier("FormTableViewController") as! FormTableViewController
        return main
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.HIBackground
        self.setNavBarWithBackButton()

    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return HImanager.supplierArray.count + 2
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("NameTableViewCell", forIndexPath: indexPath) as! NameTableViewCell
            cell.configureNameCell()
            return cell
        }
        if indexPath.row > 0 && indexPath.row <= HImanager.supplierArray.count{
            let cell = tableView.dequeueReusableCellWithIdentifier("SupplierTableViewCell", forIndexPath: indexPath) as! SupplierTableViewCell
            cell.configureSupplierCell(indexPath.row-1)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier("ImageTableViewCell", forIndexPath: indexPath) as! ImageTableViewCell
            
            return cell
        }
    }
    
    override func tableView(tableView: UITableView,
                            willDisplayCell cell: UITableViewCell,
                                            forRowAtIndexPath indexPath: NSIndexPath) {
        
        guard let tableViewCell = cell as? ImageTableViewCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension FormTableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath)
        cell.contentView.backgroundColor = UIColor.cyanColor()
        //cell.backgroundColor = model[collectionView.tag][indexPath.item]
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
    }
}
