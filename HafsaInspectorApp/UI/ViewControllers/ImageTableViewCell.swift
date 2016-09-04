//
//  ImageTableViewCell.swift
//  HafsaInspectorApp
//
//  Created by Junaid Mahmood on 9/3/16.
//  Copyright © 2016 Mahmood. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    func setCollectionViewDataSourceDelegate
        <D: protocol<UICollectionViewDataSource, UICollectionViewDelegate>>
        (dataSourceDelegate: D, forRow row: Int) {
        
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        collectionView.reloadData()
    }

    
}
