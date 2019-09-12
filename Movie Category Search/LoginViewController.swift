//
//  LoginViewController.swift
//  Movie Category Search
//
//  Created by Aleksandr Glushko on 06.09.19.
//  Copyright © 2019 tardis. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var loginButton = UIButton()
    var _username = UITextField()
    var _password = UITextField()
    var appName = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // set label
        self.appName.frame = CGRect(x: 0, y: 0, width: 300, height: 100)
        self.appName.center = CGPoint(x: 205, y: 250)
        self.appName.textAlignment = .center
        self.appName.font = UIFont.boldSystemFont(ofSize: 32.0)
        self.appName.textColor = UIColor.white
        self.appName.numberOfLines = 2
        self.appName.text = "Movie \nSearch"
        self.view.addSubview(self.appName)
        
        // set username textfield
        self._username.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        self._username.center = CGPoint(x: 205, y: 355)
        self._username.borderStyle = UITextField.BorderStyle.roundedRect
        self._username.font = UIFont.systemFont(ofSize: 18)
        self._username.placeholder = "Username"
        self.view.addSubview(self._username)
        
        // set password textfield
        self._password.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        self._password.center = CGPoint(x: 205, y: 405)
        self._password.borderStyle = UITextField.BorderStyle.roundedRect
        self._password.font = UIFont.systemFont(ofSize: 18)
        self._password.placeholder = "Password"
        self._password.isSecureTextEntry = true
        self.view.addSubview(self._password)
        
        // Set Login Button
        self.loginButton = UIButton(type: .roundedRect)
        self.loginButton.frame = CGRect(x: 0, y: 0, width: 150, height: 30)
        self.loginButton.center = CGPoint(x: 205, y: 485)
        self.loginButton.setTitle("Login", for: .normal)
        self.loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        self.loginButton.layer.cornerRadius = 10
        self.loginButton.backgroundColor = UIColor.white
        self.loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        self.view.addSubview(self.loginButton)
        
        // set background
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpg")!)
        
        
    }
    
    @objc func loginButtonPressed(_ sender: Any) {
        let homeVC = HomeViewController()
        let username = self._username.text
        let password = self._password.text
        
        if (password == "" && username == ""){
            // if fields are empty
            self.buttonPressed(title: "", message: "Credentials Required", style: .alert)
        } else if (password != "admin" && username != "admin"){
            // if credentials are wrong
            self.buttonPressed(title: "", message: "Wrong Credentials", style: .alert)
        } else {
            // go to the next screen
            self.navigationController?.pushViewController(homeVC, animated: true)
            // set a function that sets movie list for a user
        }
    }
    
    func buttonPressed(title: String, message: String, style: UIAlertController.Style){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
        }
        
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
}
