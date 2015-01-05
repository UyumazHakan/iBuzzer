//
//  RegisterViewController.swift
//  App
//
//  Created by student1 on 24/12/14.
//  Copyright (c) 2014 Hakan Uyumaz. All rights reserved.
//
import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var surname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var password2: UITextField!

    
    let domain = "http://localhost:5000"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func register(sender: AnyObject) {
        var usernameText = username.text
        var nameText = name.text
        var surnameText = surname.text
        var emailText = email.text
        var passwordText = password.text
        var password2Text = password2.text
        var request = HTTPTask()
        let params: Dictionary<String,AnyObject> = ["username": usernameText, "name": nameText, "surname": surnameText, "email": emailText, "password": passwordText]
        request.POST(domain+"/register", parameters: params, success: {(response: HTTPResponse) in
            let data = response.responseObject as NSData
            let str = NSString(data: data, encoding: NSUTF8StringEncoding)
            print("--------RESPONSE--------")
            print(str)
            },failure: {(error: NSError, response: HTTPResponse?) in
                let data = response!.responseObject as NSData
                let str = NSString(data: data, encoding: NSUTF8StringEncoding)
                print("--------ERRORS--------")
                print(error)
                print("--------RESPONSE--------")
                print(str)
        })
    }
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    
}

