//
//  ImageTableViewCell.swift
//  HafsaInspectorApp
//
//  Created by Junaid Mahmood on 9/3/16.
//  Copyright © 2016 Mahmood. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, EditedImageDelegate, SaveImageDelegate {
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var imagesArr: NSMutableArray = []
        
    override func layoutSubviews() {
        self.selectionStyle = UITableViewCellSelectionStyle.None

        addImageButton.backgroundColor = UIColor.whiteColor()
        addImageButton.tintColor = UIColor.blackColor()
        addImageButton.titleLabel?.textColor = UIColor.blackColor()
        addImageButton.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 16)
        addImageButton.layer.cornerRadius = 4
        addImageButton.layer.borderWidth = 1
        addImageButton.layer.borderColor = UIColor.blackColor().CGColor
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArr.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! AddImageCollectionViewCell
        cell.takenImage.image = imagesArr.objectAtIndex(indexPath.row) as? UIImage
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let vc = EditImageViewController.create(false)
        vc.delegate = self
        vc.image = (self.imagesArr.objectAtIndex(indexPath.row) as? UIImage)!
        parentViewController?.presentViewController(vc, animated: true, completion: nil)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(40, 50)
    }

//MARK: Actions
    
    @IBAction func addImageButtonPressed(sender: AnyObject) {
//        let vc = IPDFView().create()
//        vc.delegate = self
//        parentViewController?.navigationController?.pushViewController(vc, animated: true)
        let vc = MMCameraPickerController().create()
//        vc.delegate = self
        parentViewController?.navigationController?.pushViewController(vc, animated: true)

    }
    
    
    //Delegate method when coming from camera
    func imageSaved(image: UIImage!) {
        imagesArr.addObject(image)
        dispatch_async(dispatch_get_main_queue()) {
            self.collectionView.reloadData()
        }
    }
    
    //Delegate method when coming from cell
    func deleteImage(image: UIImage) {
        for pic in imagesArr {
            if pic as! UIImage == image {
                imagesArr.removeObject(pic)
                dispatch_async(dispatch_get_main_queue()) {
                    self.collectionView.reloadData()
                }
            }
        }
    }
}
