//
//  OfficialRestarauntTableViewController.swift
//  AutoLayout
//
//  Created by Saahil Chhabria on 23/07/15.
//  Copyright (c) 2015 Saahil Chhabria. All rights reserved.
//

import UIKit

class OfficialRestarauntTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let attributes = [
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName: UIFont(name:"Avenir", size: 24)!
        ]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        self.navigationController?.navigationBar.barTintColor = UIColor.orangeColor()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.tabBarController?.tabBar.tintColor = UIColor.orangeColor()
        self.tabBarController?.tabBar.hidden = false
    }
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
    }
}
