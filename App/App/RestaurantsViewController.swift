//
//  RestaurantsViewController.swift
//  App
//
//  Created by student1 on 24/12/14.
//  Copyright (c) 2014 Hakan Uyumaz. All rights reserved.
//

import UIKit

class RestaurantsViewController: UITableViewController {
    
    let domain = "http://localhost"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        request.POST(domain+"/restaurants", parameters: [], success: {(response: HTTPResponse) in
            
            },failure: {(error: NSError, response: HTTPResponse?) in
                print(response)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


