//
//  signUpViewController.swift
//  AutoLayout
//
//  Created by Saahil Chhabria on 16/07/15.
//  Copyright (c) 2015 Saahil Chhabria. All rights reserved.
//

import UIKit

class signUpViewController: UIViewController {
    
    let api = ViandsAPI()
    var inputtextField:UITextField?
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var conPassword: UITextField!
    @IBOutlet weak var signUpSwitch: UISwitch!
    var otpPhone:String!
    
    func displayMyAlertMessage(userMessage:String) {
        let myAlert = UIAlertController(title: "Alert", message:userMessage , preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil)
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
    }
    @IBAction func postSignUp(sender: UIButton) {
        
        let tname = name.text
        let tpassword = password.text
        let temail = email.text
        let tphone = phoneNumber.text
        let NSSphone = phoneNumber.text! as NSString
        let tconPassword = conPassword.text
        
        if (tname!.isEmpty || tpassword!.isEmpty || temail!.isEmpty || tphone!.isEmpty){
            displayMyAlertMessage("All Fields are Mandatory")
            return
        }
        if (tpassword != tconPassword){
            displayMyAlertMessage("Passwords Do Not Match")
        }
        if (signUpSwitch.on == false){
            displayMyAlertMessage("Agree the terms and conditions before continuing")
        }
        if (NSSphone.length != 10) {
            displayMyAlertMessage("Phone Number has to be 10 Digits")
        }
        else{
            
            var parameters = ["email":email.text!,"password":password.text!,"phone":phoneNumber.text!,"name":name.text!] as Dictionary<String,String>
            let qos = Int(QOS_CLASS_USER_INITIATED.rawValue)
            dispatch_async(dispatch_get_global_queue(qos, 0)) { () -> Void in
                self.api.postSignUpData(parameters, url: URL.signUpServerUrl, postcompleted: { (succeded, msg) -> Void in
                    dispatch_async(dispatch_get_main_queue()) { () -> Void in
                        var cAlert = UIAlertController(title: "Alert", message:"Registration is Successful,you will recieve an OTP momentarily", preferredStyle: UIAlertControllerStyle.Alert)
                        let ok = UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: { (alert:UIAlertAction) -> Void in
                            self.performSegueWithIdentifier("showOTP", sender: nil)
                        })
                        cAlert.addAction(ok)
                        self.presentViewController(cAlert,animated:true,completion:nil)
                    }
                }, error2: { (msg) -> Void in
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                      self.displayMyAlertMessage(msg)
                    }
            NSUserDefaults.standardUserDefaults().setObject(self.name.text, forKey: "name")
            NSUserDefaults.standardUserDefaults().setObject(self.phoneNumber.text, forKey: "phoneNumber")
            })
    }
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showOTP" {
            if let otv = segue.destinationViewController as? OTPViewController {
                otv.phoneNumber = self.otpPhone
                }   
            }
        }

    
override func viewDidLoad() {
        super.viewDidLoad()
        self.otpPhone = self.phoneNumber.text
        print(self.otpPhone)
        // Do any additional setup after loading the view.
    }
    
    
}
