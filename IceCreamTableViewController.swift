//
//  IceCreamTableViewController.swift
//  AutoLayout
//
//  Created by Saahil Chhabria on 23/07/15.
//  Copyright (c) 2015 Saahil Chhabria. All rights reserved.
//

import UIKit
 var icearray = [Restraunt]()
 var iceImageArray = [UIImage]()
 var CacheUrlIce = [String]()
 var imageDataIce = [NSData]()
class IceCreamTableViewController: UITableViewController ,UISearchBarDelegate{

    var searchActive : Bool = false
    var filteredArray = [Restraunt]()
 
    @IBOutlet weak var searchingBar: UISearchBar!
    
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
     self.navigationItem.title = "Chinese"
    self.do_table_refresh()
    self.tabBarController?.tabBar.hidden = false
    }
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
    // MARK: - Search Bar Delegate
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredArray = icearray.filter({ (item: Restraunt) -> Bool in
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
    


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    // MARK: - TableViewDelegate
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (searchActive) {
            return self.filteredArray.count
        } else {
            return icearray.count
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ice", forIndexPath: indexPath) as! IceTableViewCell
        let row  = indexPath.row
        var res : Restraunt
        // Check to see whether the normal table or search results table is being displayed and set the Candy object from the appropriate array
        if (searchActive) {
            res = filteredArray[indexPath.row]
        } else {
            res = icearray[indexPath.row]
        }

        cell.iceName.text = res.name
        cell.icePrice.text = "Price: ₹ " + res.cost.stringValue
        //cell.iceImage.image = iceImageArray[row]
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showOrderIce", sender: nil)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showOrderIce" {
            let controller = segue.destinationViewController as! displayOrderViewController
            
            let resSegue: Restraunt
            
            if let foodIndex = tableView.indexPathForSelectedRow?.row {
                
                if searchActive{
                    resSegue = filteredArray[foodIndex]
                } else {
                    resSegue = icearray[foodIndex]
                }
                
                controller.name = resSegue.name
                controller.price = resSegue.cost.stringValue
                controller.id = resSegue.id
                //controller.tempImg = iceImageArray[foodIndex]
                navigationItem.title = " "
            }
            
        }
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
}
