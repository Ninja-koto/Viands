//
//  ResTableViewController.swift
//  AutoLayout
//
//  Created by Saahil Chhabria on 20/07/15.
//  Copyright (c) 2015 Saahil Chhabria. All rights reserved.
//

import UIKit

var resArray = [Restraunt]()

class ResTableViewController: UITableViewController,UISearchBarDelegate {
    
    var check = false
    var rimage = [UIImage]()
    
    var filteredArray = [Restraunt]()
    var searchActive : Bool = false
    @IBOutlet weak var searchingBar: UISearchBar!
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
        self.view.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
        self.view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
        self.view.endEditing(true)
    }
    
    // MARK: - TableViewDelegate
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filteredArray.count
        }
        return resArray.count
    }
    func do_table_refresh()
    {
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
            return
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchingBar.delegate = self
        self.tabBarController?.tabBar.hidden = false
        
        
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title = "Vegetarian"
        self.tabBarController?.tabBar.hidden = false
        self.do_table_refresh()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    // MARK: - Search Bar Delegate
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredArray = resArray.filter({ (item: Restraunt) -> Bool in
            let stringMatch = item.name.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return (stringMatch != nil)
        })
        if(filteredArray.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TextCell", forIndexPath: indexPath) as! TextCellTableViewCell
        let row = indexPath.row
        var res : Restraunt
        // Check to see whether the normal table or search results table is being displayed and set the Candy object from the appropriate array
        if(searchActive){
            res = filteredArray[indexPath.row]
        } else {
            res = resArray[indexPath.row];
        }
        cell.foodName.text = res.name
        cell.foodPrice.text = "Price: ₹ " + res.cost.stringValue
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.performSegueWithIdentifier("showOrderVeg", sender: nil)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showOrderVeg" {
            let controller = segue.destinationViewController as! displayOrderViewController
            let resSegue: Restraunt
            
            if let foodIndex = tableView.indexPathForSelectedRow?.row {
                if(searchActive){
                    resSegue = filteredArray[foodIndex]
                } else {
                    resSegue = resArray[foodIndex];
                }
                controller.name = resSegue.name
                controller.price = resSegue.cost.stringValue
                controller.id = resSegue.id
                navigationItem.title = " "
            }
        }
        
}
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
}
