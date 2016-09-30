//
//  EditImageViewController.swift
//  HafsaInspectorApp
//
//  Created by Sameer Siddiqui on 9/6/16.
//  Copyright © 2016 Mahmood. All rights reserved.
//

import UIKit

@objc protocol EditedImageDelegate {
    @objc optional func didSaveImage(_ image: UIImage)
    @objc optional func didDiscardImage()
    @objc optional func deleteImage(_ image: UIImage)
}

class EditImageViewController: UIViewController {

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    var image:UIImage = UIImage()
    var fromCamera: Bool = false
    var delegate: EditedImageDelegate! = nil

    
    static func create(_ fromCamera: Bool) -> EditImageViewController {
        let frameworkBundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: frameworkBundle)
        let main = storyboard.instantiateViewController(withIdentifier: "EditImageViewController") as! EditImageViewController
        main.fromCamera = fromCamera
        return main
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.HIBackground
        self.imageView.contentMode = .scaleAspectFit

        self.imageView.image = image
        
        if !fromCamera {
            saveButton.setTitle("Back", for: UIControlState())
        }
        
        saveButton.backgroundColor = UIColor.white
        saveButton.tintColor = UIColor.black
        saveButton.titleLabel?.textColor = UIColor.black
        saveButton.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 16)
        saveButton.layer.cornerRadius = 4
        saveButton.layer.borderWidth = 1
        saveButton.layer.borderColor = UIColor.white.cgColor
        
        deleteButton.backgroundColor = UIColor.white
        deleteButton.tintColor = UIColor.red
        deleteButton.titleLabel?.textColor = UIColor.white
        deleteButton.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 16)
        deleteButton.layer.cornerRadius = 4
        deleteButton.layer.borderWidth = 1
        deleteButton.layer.borderColor = UIColor.red.cgColor
    }

    @IBAction func saveButtonPressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
        if fromCamera {
            self.delegate.didSaveImage!(image)
        }
    }

    @IBAction func deleteButtonPressed(_ sender: AnyObject) {
        if !fromCamera {
            self.delegate.deleteImage!(self.image)
        }
        else {
            self.delegate.didDiscardImage!()
        }
        self.dismiss(animated: true, completion: nil)
    }
}
