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
    
    let domain = "http://localhost:5000"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func handleResponse(response: JSON) {
        UserManager.sharedInstance.user = User(json: response)
    }
    
}

