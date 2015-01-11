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
    
    @IBOutlet weak var loginButton: UIButton!
    
    let domain = "http://localhost:5000"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loginButton.enabled = false
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
    @IBAction func check(sender: AnyObject) {
        println("------CHECK LOGIN-----")
        println(email.text)
        println(password.text)
        if email.text != "" && password.text != "" && isValidEmail(email.text) {
            loginButton.enabled = true
        } else {
            loginButton.enabled = false
        }
    }
    func isValidEmail(testStr:String) -> Bool {
        println("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        var emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest!.evaluateWithObject(testStr)
        return result
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

