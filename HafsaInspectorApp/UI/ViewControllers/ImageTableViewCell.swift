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
        self.selectionStyle = UITableViewCellSelectionStyle.none

        addImageButton.backgroundColor = UIColor.white
        addImageButton.tintColor = UIColor.black
        addImageButton.titleLabel?.textColor = UIColor.black
        addImageButton.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 16)
        addImageButton.layer.cornerRadius = 4
        addImageButton.layer.borderWidth = 1
        addImageButton.layer.borderColor = UIColor.black.cgColor
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! AddImageCollectionViewCell
        cell.takenImage.image = imagesArr.object(at: (indexPath as NSIndexPath).row) as? UIImage
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = EditImageViewController.create(false)
        vc.delegate = self
        vc.image = (self.imagesArr.object(at: (indexPath as NSIndexPath).row) as? UIImage)!
        parentViewController?.present(vc, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40, height: 50)
    }

//MARK: Actions
    
    @IBAction func addImageButtonPressed(_ sender: AnyObject) {
        let vc = IPDFView().create()
        vc?.delegate = self
        parentViewController?.navigationController?.pushViewController(vc!, animated: true)
        
//        let vc = MMCameraPickerController().create()
//        //        vc.delegate = self
//        parentViewController?.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    //Delegate method when coming from camera
    func imageSaved(_ image: UIImage!) {
        imagesArr.add(image)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    //Delegate method when coming from cell
    func deleteImage(_ image: UIImage) {
        for pic in imagesArr {
            if pic as! UIImage == image {
                imagesArr.remove(pic)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
}
