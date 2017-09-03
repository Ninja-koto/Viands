//
//  SignInViewController.swift
//  AutoLayout
//
//  Created by Saahil Chhabria on 15/07/15.
//  Copyright (c) 2015 Saahil Chhabria. All rights reserved.
//

import UIKit
import Foundation
class SignInViewController: UIViewController
{
    let ob = ViandsAPI()
    let MyKeychainWrapper = KeychainWrapper()
    let createLoginButtonTag = 0
    let loginButtonTag = 1
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUp: UIButton!
    
    @IBAction func logIn(sender: UIButton) {
        let tphone = phoneTextField.text! as NSString
        if (phoneTextField.text!.isEmpty || passwordTextField.text!.isEmpty){
            displayMyAlertMessage("All Fields are Mandatory")
            return;
        }
        if (tphone.length != 10){
            displayMyAlertMessage("Phone Number has to be 10 Digits")
            return;
            
        }
        else {
            
            let qos = Int(QOS_CLASS_USER_INITIATED.rawValue)
            dispatch_async(dispatch_get_global_queue(qos, 0)) { () -> Void in
            self.ob.postLogin(["phone":self.phoneTextField.text!,"password":self.passwordTextField.text!], url: URL.loginServerUrl, postCompleted: { (succeeded, msg) -> Void in
                    dispatch_async(dispatch_get_main_queue()) { () -> Void in
                        print("Login failed\n")
                        self.displayMyAlertMessage(msg)
                        self.phoneTextField.text = nil
                        self.passwordTextField.text = nil
                    }
                    
                    }, postData: { (uphone,name,email,otp) -> Void in
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.MyKeychainWrapper.mySetObject(self.passwordTextField.text, forKey:kSecValueData)
                            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "hasLoginKey")
                            NSUserDefaults.standardUserDefaults().synchronize()
                            self.MyKeychainWrapper.writeToKeychain()
                            self.phoneTextField.text = nil
                            self.passwordTextField.text = nil
                          self.performSegueWithIdentifier("showHome", sender: nil)
                            
                        })
                        
                })
                
            }
            
        }

    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
         self.view.endEditing(true)
    }
    
    func displayMyAlertMessage(userMessage:String) {
        let myAlert = UIAlertController(title: "Alert", message:userMessage , preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil)
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
        return
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    
}
