//
//  RestrauntData.swift
//  AutoLayout
//
//  Created by Saahil Chhabria on 20/07/15.
//  Copyright (c) 2015 Saahil Chhabria. All rights reserved.
//

import Foundation

class Restraunt
{
    let id :String!
    let available:Bool!
    let category:String!
    let cost:NSNumber!
    let name:String!
    let sno:NSNumber!
    var res = [Restraunt]()
    init(id:String!,available:Bool,category:String!,cost:NSNumber,name:String!,sno:NSNumber){
        self.id = id
        self.available = available
        self.category = category
        self.cost = cost
        self.name = name
        self.sno = sno
    }
    func pushOnOrderStack(item:Restraunt) {
        self.res.append(item)
        
    }
}