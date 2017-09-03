//
//  OTPViewController.swift
//  AutoLayout
//
//  Created by Saahil Chhabria on 04/08/15.
//  Copyright (c) 2015 Saahil Chhabria. All rights reserved.
//

import UIKit

class OTPViewController: UIViewController {
    var olx = ViandsAPI()
    var phoneNumber:String!
    func displayMyAlertMessage(userMessage:String) {
        let myAlert = UIAlertController(title: "Alert", message:userMessage , preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil)
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
    }
    @IBOutlet weak var otpTextField: UITextField!
    @IBAction func verify(sender: AnyObject) {
        
      self.olx.verify(["phone":phoneNumber!,"otp":otpTextField.text!], url: URL.signUpServerUrl, postcompleted: { (succeded, msg) -> Void in
        self.displayMyAlertMessage("Welcome to viands")
        self.performSegueWithIdentifier("showSignUp", sender: nil)
      }) { (msg) -> Void in
        self.displayMyAlertMessage("msg")
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
