//
//  LoginViewController.swift
//  App
//
//  Created by student1 on 24/12/14.
//  Copyright (c) 2014 Hakan Uyumaz. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    let domain = "http://localhost"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(sender: AnyObject) {
        var emailText = email.text
        var passwordText = password.text
        var request = HTTPTask()
        let params: Dictionary<String,AnyObject> = ["email": emailText, "password": passwordText]
        request.POST(domain+"/login", parameters: params, success: {(response: HTTPResponse) in
            
            },failure: {(error: NSError, response: HTTPResponse?) in
                print(response)
        })
    }
    
}

