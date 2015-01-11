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
    
    
    let domain = "http://localhost:5000"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Login" {
            login()
            
        }
    }
    func login() {
        var emailText = email.text
        var passwordText = password.text
        var request = HTTPTask()
        let params: Dictionary<String,AnyObject> = ["email": emailText, "pass": passwordText]
        request.POST(domain+"/auth", parameters: params, success: {(response: HTTPResponse) in
                let data = response.responseObject as NSData
                let str = NSString(data: data, encoding: NSUTF8StringEncoding)
                let json = JSON.parse(str!)
                print("--------RESPONSE--------")
                print(str)
                self.handleResponse(json)
            },failure: {(error: NSError, response: HTTPResponse?) in
                let data = response!.responseObject as NSData
                let str = NSString(data: data, encoding: NSUTF8StringEncoding)
                print("--------ERRORS--------")
                print(error)
                print("--------RESPONSE--------")
                print(str)
        })
    }
    
    func handleResponse(response: JSON) {
        UserManager.sharedInstance.user = User(json: response)
    }
    
}

