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
    @IBOutlet weak var register: UIButton!
    
    let domain = "http://localhost:5000"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        register.enabled = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func check(sender: AnyObject) {
        if username.text != "" && name.text != "" && surname.text != "" && email.text != "" && password.text != "" && password2.text != "" && password.text == password2.text && isValidEmail(email.text) {
            register.enabled = true
        } else {
            register.enabled = false
        }
    }
    func isValidEmail(testStr:String) -> Bool {
        println("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        var emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest!.evaluateWithObject(testStr)
        return result
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
                print("--------ERRORS--------")
                print(error)
        })
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    
}

