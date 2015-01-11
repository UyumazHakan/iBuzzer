//
//  OrderViewController.swift
//  App
//
//  Created by student1 on 06/01/15.
//  Copyright (c) 2015 Hakan Uyumaz. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController {
 
    @IBOutlet weak var restaurant: UILabel!
    @IBOutlet weak var ready: UILabel!
    @IBOutlet weak var preparing: UILabel!
    var restaurantName = ""
    var isNameSet = false
    var isReady = false
    
    let domain = "http://localhost:5000"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND,0), {
            while true {
                
                self.updateView()
                sleep(3)
            }
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    func updateView() {
        updateRequestData()

    }
    func updateRequestData(){
        var userID = UserManager.sharedInstance.user?.id
        var request = HTTPTask()
        let params: Dictionary<String,AnyObject> = ["user": userID!]
        request.POST(domain+"/user_request", parameters: params, success: {(response: HTTPResponse) in
            let data = response.responseObject as NSData
            let str = NSString(data: data, encoding: NSUTF8StringEncoding)
            let json = JSON.parse(str!)
            println("--------RESPONSE--------")
            self.updateRestaurantName(json["RESTAURANT"].asInt!)
            println(str)
            if (json["IS_DONE"].asInt! == 1) {
                self.isReady = true
            } else {
                self.isReady = false
            }
            },failure: {(error: NSError, response: HTTPResponse?) in
                print("--------ERRORS--------")
                print(error)
        })
        
    }
    func updateRestaurantName(id : Int) {
        let params: Dictionary<String,AnyObject> = [:]
        var request = HTTPTask()
        request.GET(domain+"/restaurants", parameters: params, success: {(response: HTTPResponse) in
            let data = response.responseObject as NSData
            let str = NSString(data: data, encoding: NSUTF8StringEncoding)
            let json = JSON.parse(str!)
            print("--------RESPONSE--------")
            print(str)
            self.restaurantName = self.getNameOfID(id, json: json)
            self.isNameSet = true
            dispatch_async(dispatch_get_main_queue(), {
                self.restaurant.text = self.restaurantName
                if self.isReady {
                    self.ready.hidden = false
                    self.preparing.hidden = true
                } else {
                    self.ready.hidden = true
                    self.preparing.hidden = false
                }
            })
            },failure: {(error: NSError, response: HTTPResponse?) in
                let data = response!.responseObject as NSData
                let str = NSString(data: data, encoding: NSUTF8StringEncoding)
                print("--------ERRORS--------")
                print(error)
                print("--------RESPONSE--------")
                print(str)
        })
        
    }
    func getNameOfID(id : Int, json : JSON) -> String{
        let jsonList = json.asArray!
        for jsonElement in jsonList {
            if jsonElement["ID"].asInt! == id {
                return jsonElement["NAME"].asString!
            }
        }
        return "ERROR"
    }
    
}

