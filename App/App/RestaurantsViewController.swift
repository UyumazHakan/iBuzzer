//
//  RestaurantsViewController.swift
//  App
//
//  Created by student1 on 24/12/14.
//  Copyright (c) 2014 Hakan Uyumaz. All rights reserved.
//

import UIKit

class RestaurantsViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {
    
    let domain = "http://localhost:5000"
    
    var restaurants = [Restaurant]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let params: Dictionary<String,AnyObject> = [:]
        var request = HTTPTask()
        request.GET(domain+"/restaurants", parameters: params, success: {(response: HTTPResponse) in
            let data = response.responseObject as NSData
            let str = NSString(data: data, encoding: NSUTF8StringEncoding)
            let json = JSON.parse(str!)
            let jsonList = json.asArray!
            print("--------RESPONSE--------")
            print(str)
            self.createRestaurantList(jsonList)
            self.tableView.reloadData()
            },failure: {(error: NSError, response: HTTPResponse?) in
                let data = response!.responseObject as NSData
                let str = NSString(data: data, encoding: NSUTF8StringEncoding)
                print("--------ERRORS--------")
                print(error)
                print("--------RESPONSE--------")
                print(str)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Menu" {
            let cell = sender as UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let restaurant = restaurants[indexPath!.item]
            let vc = segue.destinationViewController as MenuViewController
            vc.restaurant = restaurant
            
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("COUNT:" , restaurants.count)
        return restaurants.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Restaurant") as UITableViewCell
        let restaurant = restaurants[indexPath.item]
        println("Cell:" + restaurant.name)
        cell.textLabel!.text = restaurant.type
        cell.detailTextLabel!.text = restaurant.name
        return cell
    }
    func createRestaurantList(jsonList: [JSON]){
        for json in jsonList {
            self.restaurants.append(Restaurant(json: json))
        }
    }
    
}


