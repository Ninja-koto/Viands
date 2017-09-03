//
//  ViandsAPI.swift
//  Viands_IOS
//
//  Created by Saahil Chhabria on 07/07/15.
//  Copyright (c) 2015 Saahil Chhabria. All rights reserved.
//
import Foundation

class ViandsAPI:NSObject
{
    func verify(param:Dictionary<String,String>,url:String,postcompleted:(succeded:Bool,msg:String)->Void,error1:(msg:String)->Void) ->Void
    {
        var json:AnyObject!
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        var err: NSError?
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(param, options: [])
        } catch var error as NSError {
            err = error
            request.HTTPBody = nil
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if (error != nil){
                print("there was a network error\n")
                print(error)
                error1(msg:"There was a network error")
            }
            else {
                print("Response: \(response)")
                var strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Body: \(strData)")
                var err: NSError?
                do {
                var json =  try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
                }
                catch {
                    print(error)
                    request.HTTPBody = nil
                }
                    // The JSONObjectWithData constructor didn't return an error. But, we should still
                    // check and make sure that json has a value using optional binding.
                    if let parseJSON = json {
                        print("Okay, the parsedJSON is here\n", terminator: "")
                        if let error = parseJSON["err"]  as? Bool {
                            if (error == true) {
                    print("Error is here\n", terminator: "")
                                error1(msg:"OTp does not match")
                
                    
                }
            }
                    }
                }
            })
            
        task.resume()
    }
    
    func postLogin(params : Dictionary<String, String>, url : String, postCompleted : (succeeded: Bool, msg: String) -> Void, postData:(uphone:NSNumber,name:String,email:String,otp:String)->Void) {
        var json:AnyObject!
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        var err: NSError?
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
        } catch var error as NSError {
            err = error
            request.HTTPBody = nil
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if (error != nil){
                print("there was a network error\n")
                postCompleted(succeeded: false, msg: "There was a network error")
                print(error)
                postCompleted(succeeded: false, msg: "There was a network error")
            }
            else {
            //println("Response: \(response)")
            var strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
            //println("Body: \(strData)")
            var err: NSError?
                do {
            var json =  try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
                }
                catch {
                    print(error)
                    request.HTTPBody = nil
                }
            
            var msg = "No message"
            
            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if(err != nil) {
                print("There was an error printing the json object\n")
                print(err!.localizedDescription)
                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Error could not parse JSON: '\(jsonStr)'")
                postCompleted(succeeded: false, msg: "There was an error printing the json object")
            }
            else {
                // The JSONObjectWithData constructor didn't return an error. But, we should still
                // check and make sure that json has a value using optional binding.
                if let parseJSON = json {
                    print("Okay, the parsedJSON is here\n", terminator: "")
                    if let error = parseJSON["err"]  as? Bool {
                        if (error == true) {
                            print("Error is here\n", terminator: "")
                            print("Phone or password is incorrect\n")
                            print(error)
                            postCompleted(succeeded: false, msg: "Phone or password is incorrect")
                        }
                        if (error == false){
                            
                            if let message = parseJSON["message"] as? String {
                                
                                if let user = parseJSON["user"] as? NSDictionary {
                                    
                                    if let uphone = user["phone"] as? NSNumber {
                                        
                                        if let name = user["name"] as? String {
                                            
                                            if let email = user["email"] as? String {
                                                
                                                if let otp = user["otp"] as? String {
                                                    postData(uphone: uphone, name: name, email: email, otp: otp)
                                                    
                                                }
                                                
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                else {
                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                    let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print("Error could not parse JSON the object was nil: \(jsonStr)")
                    postCompleted(succeeded: false, msg: "Error")
                }
            }
            }
            
        })
        task.resume()
        
    }
    
    func postSignUpData(param:Dictionary<String,String>,url:String,postcompleted:(succeded:Bool,msg:String)->Void,error2:(msg:String)->Void) ->Void{
        var json:AnyObject!
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        var err: NSError?
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(param, options: [])
        } catch var error as NSError {
            err = error
            request.HTTPBody = nil
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if (error != nil){
                print("there was a network error\n")
                print(error)
                error2(msg:"there was a network error")
            }
            else {
            print("Response: \(response)")
            var strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("Body: \(strData)")
                var err: NSError?
                do {
                var json =  try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
                }
                catch {
                    print(error)
                    request.HTTPBody = nil
                }
                
                var msg = "No message"
                
                // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
                if(err != nil) {
                    print("There was an error printing the json object\n")
                    print(err!.localizedDescription)
                    let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print("Error could not parse JSON: '\(jsonStr)'")
                    error2(msg:"Error could not parse JSON")
                    
                }
                else {
                    // The JSONObjectWithData constructor didn't return an error. But, we should still
                    // check and make sure that json has a value using optional binding.
                    if let parseJSON = json {
                        print("Okay, the parsedJSON is here\n", terminator: "")
                        if let error = parseJSON["err"]  as? Bool {
                            if (error == true) {
                                print("Error is here\n", terminator: "")
                                error2(msg:"The Phone number exists")
                                
                            }
                            else if (error == false) {
                                postcompleted(succeded: true, msg: "It Succeeded")
                            }
                        }
                    }
                }
            }
                    })
        task.resume()
    }
    func getRestraunts(){
        var jsonResult:NSDictionary!
        let err: NSError?
        let urlPath = URL.restaurantsServerUrl
        let url = NSURL(string: urlPath)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
            print("Task completed\n")
            if(error != nil) {
                print("If there is an error in the web request, print it to the console\n")
                print(error!.localizedDescription, terminator: "")
            }
            do {
                let jsonDict = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue: 0)) as? NSDictionary
                print(jsonDict)
             
                    let qos = Int(QOS_CLASS_USER_INITIATED.rawValue)
                    dispatch_async(dispatch_get_global_queue(qos, 0)) { () -> Void in
                        print("Connection carried\n", terminator: "")
                        if let error = jsonDict!["err"] as? Bool {
                            if (error == true) {
                                print(error)
                            }
                            else if(error == false) {
                                if let message = jsonDict!["message"] as? String {
                                    if let restaurants = jsonDict!["restaurants"] as? NSArray {
                                        for index in 0...restaurants.count-1 {
                                            let member : AnyObject? = restaurants[index]
                                            if let memberVIP = member as? NSDictionary{
                                                if let menu = memberVIP["menu"] as? NSArray {
                                                    for item in 0...menu.count-1 {
                                                        let food :AnyObject? = menu[item]
                                                        if let foodDic = food as? NSDictionary {
                                                            if let id = foodDic["_id"] as? String {
                                                                if let available = foodDic["available"] as? NSNumber {
                                                                    if let category = foodDic["category"] as? String {
                                                                        if let cost = foodDic["cost"] as? NSNumber {
                                                                            let scost : String = cost.stringValue
                                                                            if let name = foodDic["name"] as? String{
                                                                                if let sno = foodDic["sno"]
                                                                                    as? NSNumber {
                                                                                        let item = Restraunt(id: id, available: true, category: category, cost: cost, name: name, sno: sno)
                                                                                        chinesearray.append(item)
                                                                                        if (category == "1") {
                                                                                            let item = Restraunt(id: id, available: true, category: category, cost: cost, name: name, sno: sno)
                                                                                            resArray.append(item)
                                                                                            
                                                                                        }
                                                                                        else if(category == "2") {
                                                                                            let item = Restraunt(id: id, available: true, category: category, cost: cost, name: name, sno: sno)
                                                                                            nonvegarray.append(item)
                                                                                        }
                                                                                        else if(category == "3") {
                                                                                            let item = Restraunt(id: id, available: true, category: category, cost: cost, name: name, sno: sno)
                                                                                            icearray.append(item)
                                                                                        }
                                                                                        else if(category == "4") {
                                                                                            let item = Restraunt(id: id, available: true, category: category, cost: cost, name: name, sno: sno)
                                                                                            miscarray.append(item)
                                                                                        }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                    
                                                                }
                                                                
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                            
                                        }
//                                        self.do_table_refresh()
                                    }
                                }
                                
                            }
                        }
                        
                    }
                // The task is just an object with all these properties set
                // In order to actually make the web request, we need to "resume"
            }
            catch let error as NSError {
                // error handling
            }
        })//completion handler is closed here
        
        task.resume()
    }
    func canConnectToInternet() -> Bool {
        let urlPath: String = "http://www.google.com"
        let url: NSURL = NSURL(string: urlPath)!
        
        // Notice the timeoutInterval property.
        // Since this is a synchronous request you do not want it last for a long time
        let request = NSURLRequest(URL: url,
            cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData,
            timeoutInterval: 3)
        var response: NSURLResponse?
        var error: NSError?
        let urlData: NSData?
        do {
            urlData = try NSURLConnection.sendSynchronousRequest(request,
                        returningResponse: &response)
        } catch let error1 as NSError {
            error = error1
            urlData = nil
        }
        
        if let httpResponse = response as? NSHTTPURLResponse {
            print(httpResponse.statusCode)
            
            if(httpResponse.statusCode == 200) {
                return true
            }
        }
        
        return false
    }
//    data = json encoded of {
//    token:
//    rest_id
//    total_cost
//    order:
//    type:
//    time_deliver:
//    items:[{id: , quantity:, cost: }]
//    }
    func placeFinalOrder(items:Dictionary<String,String>,url:String,postcompleted:(succeded:Bool,msg:String)->Void,error2:(msg:String)->Void) ->Void{
        var json:AnyObject!
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        var err: NSError?
        var  item: NSData?
        do {
            item = try NSJSONSerialization.dataWithJSONObject(items, options: [])
        } catch var error as NSError {
            err = error
            item = nil
        }
        request.HTTPBody = item
        request.addValue("application/json",forHTTPHeaderField: "Content-Type")
        request.addValue("application/json",forHTTPHeaderField: "Accept")
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if (error != nil){
                print("there was a network error\n")
                print(error)
                error2(msg:"there was a network error")
            }
            else {
                print("Response: \(response)")
                var strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Body: \(strData)")
                var err: NSError?
                do {
                var json =  try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
                }
                catch {
                    print(error)
                    request.HTTPBody = nil
                }
                
                var msg = "No message"
                
                // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
                if(err != nil) {
                    print("There was an error printing the json object\n")
                    print(err!.localizedDescription)
                    let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print("Error could not parse JSON: '\(jsonStr)'")
                    error2(msg:"Error could not parse JSON")
                    
                }
                else {
                    // The JSONObjectWithData constructor didn't return an error. But, we should still
                    // check and make sure that json has a value using optional binding.
                    if let parseJSON = json {
                        print("Okay, the parsedJSON is here\n", terminator: "")
                        if let error = parseJSON["err"]  as? Bool {
                            if (error == true) {
                                print("Error is here\n", terminator: "")
                                error2(msg:"There is an error")
                                
                            }
                            else if (error == false) {
                                postcompleted(succeded: true, msg: "It Succeeded")
                            }
                        }
                    }
                }
            }
        })
        task.resume()


        
    }
}