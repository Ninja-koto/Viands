//
//  LoginData.swift
//  Viands_IOS
//
//  Created by Saahil Chhabria on 07/07/15.
//  Copyright (c) 2015 Saahil Chhabria. All rights reserved.
//

import Foundation


class LoginData
{
    var phone : NSNumber!
    var name : String!
    var email : String!
    var otp :String!
    
    
    init(phone: NSNumber,name:String,email:String,otp:String){
        self.phone = phone
        self.name = name
        self.email = email
        self.otp = otp
    }
    func print() {
        Swift.print("Object name returned successful: \(self.name)")
        Swift.print("Object email returned successful : \(self.email)")
        Swift.print("Object phone returned successful : \(self.phone)")
        Swift.print("Object otp returned successful : \(self.otp)")
        
    }
    
}