//
//  AccountViewController.swift
//  AutoLayout
//
//  Created by Saahil Chhabria on 14/08/15.
//  Copyright (c) 2015 Saahil Chhabria. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    
    var check:Bool!
    @IBOutlet weak var accountWallet: UILabel!
    @IBOutlet weak var accountPhoneNumber: UILabel!
    @IBOutlet weak var accountName: UILabel!
    let hasLoginKey = NSUserDefaults.standardUserDefaults().boolForKey("hasLoginKey")
    func displayAlertMessage(msg:String)-> Void {
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        let ok = UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler:nil)
        alert.addAction(ok)
        self.presentViewController(alert, animated:true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.hidden = false
        let netTest = ViandsAPI()
        check = netTest.canConnectToInternet()
        if (check == false) {
            displayAlertMessage("No Internet")
            
        }
        else {
            displayAlertMessage("There is Internet")
        }
        if (hasLoginKey == false) {
            self.performSegueWithIdentifier("showSignIn", sender: nil)
        }
        let attributes = [
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName: UIFont(name: "Avenir", size: 24)!
        ]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        self.navigationController?.navigationBar.barTintColor = UIColor.orangeColor()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.tabBarController?.tabBar.tintColor = UIColor.orangeColor()
        let name = NSUserDefaults.standardUserDefaults().stringForKey("name")
        print(name)
        
    }
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
    }
}
