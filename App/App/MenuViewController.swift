//
//  MenuViewController.swift
//  App
//
//  Created by student1 on 24/12/14.
//  Copyright (c) 2014 Hakan Uyumaz. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {
    
    var restaurant: Restaurant!
    var menu = Menu(json: JSON([]))
    
    let domain = "http://localhost:5000"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let params: Dictionary<String,AnyObject> = ["restaurant": restaurant.id]
        self.title = restaurant.name
        var request = HTTPTask()
        request.POST(domain+"/menu", parameters: params, success: {(response: HTTPResponse) in
            let data = response.responseObject as NSData
            let str = NSString(data: data, encoding: NSUTF8StringEncoding)
            let json = JSON.parse(str!)
            println(str)
            self.menu = Menu(json: json)
            print("--------RESPONSE--------")
            print(str)
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
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println(menu)
        println(menu.items)
        return menu.items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Item") as UITableViewCell
        let item = menu.items[indexPath.item]
        cell.textLabel!.text = item.price
        cell.detailTextLabel!.text = item.name
        return cell
    }
    
}


