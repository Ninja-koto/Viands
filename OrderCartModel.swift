//
//  OrderCartModel.swift
//  AutoLayout
//
//  Created by Saahil Chhabria on 11/08/15.
//  Copyright (c) 2015 Saahil Chhabria. All rights reserved.
//

import Foundation

class OrderCart {
    var id:String!
    var foodName:String!
    var qty:Int!
    var price:String!
    init (newId:String!,Name:String!,qnty:Int!,newPrice:String!){
        self.id = newId
        self.foodName = Name
        self.qty = qnty
        self.price = newPrice
    }    
}
