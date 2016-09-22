//
//  EditImageViewController.swift
//  HafsaInspectorApp
//
//  Created by Sameer Siddiqui on 9/6/16.
//  Copyright © 2016 Mahmood. All rights reserved.
//

import UIKit

@objc protocol EditedImageDelegate {
    optional func didSaveImage(image: UIImage)
    optional func didDiscardImage()
    optional func deleteImage(image: UIImage)
}

class EditImageViewController: UIViewController {

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    var image:UIImage = UIImage()
    var fromCamera: Bool = false
    var delegate: EditedImageDelegate! = nil

    
    
    static func create(fromCamera: Bool) -> EditImageViewController {
        let frameworkBundle = NSBundle.mainBundle()
        let storyboard = UIStoryboard(name: "Main", bundle: frameworkBundle)
        let main = storyboard.instantiateViewControllerWithIdentifier("EditImageViewController") as! EditImageViewController
        main.fromCamera = fromCamera
        return main
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.HIBackground
        self.imageView.contentMode = .ScaleAspectFit

        self.imageView.image = image
        
        if !fromCamera {
            saveButton.setTitle("Back", forState: .Normal)
        }
        
        saveButton.backgroundColor = UIColor.whiteColor()
        saveButton.tintColor = UIColor.blackColor()
        saveButton.titleLabel?.textColor = UIColor.blackColor()
        saveButton.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 16)
        saveButton.layer.cornerRadius = 4
        saveButton.layer.borderWidth = 1
        saveButton.layer.borderColor = UIColor.whiteColor().CGColor
        
        deleteButton.backgroundColor = UIColor.whiteColor()
        deleteButton.tintColor = UIColor.redColor()
        deleteButton.titleLabel?.textColor = UIColor.whiteColor()
        deleteButton.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 16)
        deleteButton.layer.cornerRadius = 4
        deleteButton.layer.borderWidth = 1
        deleteButton.layer.borderColor = UIColor.redColor().CGColor
    }

    @IBAction func saveButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        if fromCamera {
            self.delegate.didSaveImage!(image)
        }
    }

    @IBAction func deleteButtonPressed(sender: AnyObject) {
        if !fromCamera {
            self.delegate.deleteImage!(self.image)
        }
        else {
            self.delegate.didDiscardImage!()
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
