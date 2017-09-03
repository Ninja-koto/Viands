//
//  displayOrderViewController.swift
//  AutoLayout
//
//  Created by Saahil Chhabria on 09/08/15.
//  Copyright (c) 2015 Saahil Chhabria. All rights reserved.
//

import UIKit
var finalOrder = [OrderCart]()

class displayOrderViewController: UIViewController {
   
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var orderName: UILabel!
    @IBOutlet weak var orderPrice: UILabel!
    @IBOutlet weak var orderQuantity: UILabel!
    @IBOutlet weak var qty: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var totalCost: UILabel!
    var name:String!
    var price:String!
    var id:String!
    var tlCost:Int!
    var quantity:Int!
    var newPrice:Int!
    var tempImg:UIImage!

    @IBAction func placeOrder(sender: UIButton) {
        let item = OrderCart(newId: id, Name: name, qnty: quantity, newPrice: price)
        finalOrder.append(item)
        let alert = UIAlertController(title: "Order Placed", message: "Your Order has been placed check order cart", preferredStyle: UIAlertControllerStyle.Alert)
        let ok = UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default) { (alertAction) -> Void in
            self.qty.text = "0"
            self.totalCost.text = "0"
            self.stepper.value = 0
        }
        alert.addAction(ok)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    @IBAction func stepperChangedValue(sender: UIStepper) {
        newPrice = Int(price)
        quantity = Int(sender.value)
        qty.text = Int(sender.value).description
        self.tlCost = (newPrice! * quantity)
        totalCost.text = "₹"+String(tlCost)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        orderName.text = name
        orderPrice.text = "₹"+price
        stepper.wraps = true
        stepper.autorepeat = true
        stepper.maximumValue = 10
        self.tabBarController?.tabBar.hidden = true
        //self.image.image = tempImg
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
