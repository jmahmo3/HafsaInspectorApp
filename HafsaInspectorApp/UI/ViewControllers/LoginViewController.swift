//
//  LoginViewController.swift
//  HafsaInspectorApp
//
//  Created by Sameer Siddiqui on 9/26/16.
//  Copyright © 2016 Mahmood. All rights reserved.
//

import UIKit
import MBProgressHUD

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var password: HITextField!
    @IBOutlet weak var username: HITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.HIBackground
        self.hideKeyboardWhenTappedAround()
        
        username.delegate = self
        password.delegate = self
        
        username.placeholder = "Username"
        password.placeholder = "Password"
        
        username.autocorrectionType = .no
        password.autocorrectionType = .no
        password.isSecureTextEntry = true


        
        loginButton.backgroundColor = UIColor.white
        loginButton.tintColor = UIColor.black
        loginButton.titleLabel?.textColor = UIColor.black
        loginButton.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 24)
        loginButton.layer.cornerRadius = 4
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.white.cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonPressed(_ sender: AnyObject) {
        
        if username.text!.isEmpty  {
            createAlert("Please Enter a Username")
        }
        else if password.text!.isEmpty{
            createAlert("Please Enter a Password")
        }
        if !(password.text!.isEqual(HIManager.sharedClient().password)) {
            createAlert("Incorrect Password")
        }
        else if password.text!.isEqual(HIManager.sharedClient().password) && !username.text!.isEmpty {
            
            let progess = MBProgressHUD()
            progess.label.text = "Logging in"
            progess.tintColor = UIColor.black
            view.addSubview(progess)
            progess.center = view.center
            progess.show(animated: true)

            CurrentUser.sharedClient().signin(username.text!, { (user, error) in
                progess.hide(animated: true)
                if !(error != nil) {
                    UserDefaults.standard.set(true, forKey: "Registered")
                    let vc = ChapterPickerViewController.create()
                   _ = self.present(vc, animated: true, completion: nil)
                }
                else {
                    self.createAlert("Sorry, we could not verify your username\nPlease try again or contact your admin")
                }
            })
        }
        
        
    }

    
    //MARK: TextFieldShouldReturn
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
