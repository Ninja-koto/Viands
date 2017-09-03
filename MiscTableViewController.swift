//
//  MiscTableViewController.swift
//  AutoLayout
//
//  Created by Saahil Chhabria on 23/07/15.
//  Copyright (c) 2015 Saahil Chhabria. All rights reserved.
//

import UIKit
var miscarray = [Restraunt]()
 var miscImageArray = [UIImage]()
var CacheUrlMisc = [String]()
var DataMisc = [NSData]()
class MiscTableViewController: UITableViewController,UISearchBarDelegate {
    @IBOutlet weak var searchingBar: UISearchBar!
    var searchActive : Bool = false
    var filteredArray = [Restraunt]()
    
    var resultSearchController = UISearchController()

    func do_table_refresh()
    {
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
            return
        })
    }
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
        self.view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
        self.view.endEditing(true)
    }
    // MARK: - Search Bar Delegate
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredArray = miscarray.filter({ (item: Restraunt) -> Bool in
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

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showOrderMisc", sender: nil)
    }
    override func viewWillAppear(animated: Bool) {
    self.navigationItem.title = "Snacks"
    self.do_table_refresh()
    self.tabBarController?.tabBar.hidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationItem.title = "Juice/Shake/Water"
        searchingBar.delegate = self
        self.tabBarController?.tabBar.hidden = false
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (searchActive) {
            return filteredArray.count
        } else {
            return miscarray.count
            
        }
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCellWithIdentifier("miscCell", forIndexPath: indexPath) as! MiscTableViewCell
        let row = indexPath.row
        var res : Restraunt
        // Check to see whether the normal table or search results table is being displayed and set the Candy object from the appropriate array
        if (searchActive) {
            res = self.filteredArray[indexPath.row]
        } else {
            res = miscarray[indexPath.row]
        }
            cell.miscName.text = res.name
            cell.miscPrice.text = "Price: ₹ "+res.cost.stringValue
            //cell.miscImage.image = miscImageArray[row]
        return cell
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showOrderMisc" {
            let controller = segue.destinationViewController as! displayOrderViewController
            let resSegue: Restraunt
            
            if let foodIndex = tableView.indexPathForSelectedRow?.row {
                
                if searchActive {
                    resSegue = filteredArray[foodIndex]
                } else {
                    resSegue = miscarray[foodIndex]
                }
                controller.name = resSegue.name
                controller.price = resSegue.cost.stringValue
                controller.id = resSegue.id
                //controller.tempImg = miscImageArray[foodIndex]
                navigationItem.title = " "
            }
            
            if (self.resultSearchController.active) {
                self.resultSearchController.active = false
            }
        }
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

}
