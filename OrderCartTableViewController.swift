//
//  OrderCartTableViewController.swift
//  AutoLayout
//
//  Created by Saahil Chhabria on 09/08/15.
//  Copyright (c) 2015 Saahil Chhabria. All rights reserved.
//

import UIKit

class OrderCartTableViewController: UITableViewController {
    @IBOutlet weak var ttlCost: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let attributes = [
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName: UIFont(name: "Avenir", size: 24)!
        ]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        self.navigationController?.navigationBar.barTintColor = UIColor.orangeColor()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.tabBarController?.tabBar.tintColor = UIColor.orangeColor()
        self.tabBarController?.tabBar.hidden = false
        self.tabBarController?.tabBar.hidden = false
    }
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
        self.tabBarController?.tabBar.hidden = false
    }
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return finalOrder.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("orderCell", forIndexPath: indexPath) as! OrderTableViewCell
        let final = finalOrder[indexPath.row]
        cell.finalOrderName.text = final.foodName
        cell.finalOrderPrice.text = "Price : ₹" + final.price
        cell.quantity.text = "Quantity: " + String(final.qty)
        return cell
    }

}
