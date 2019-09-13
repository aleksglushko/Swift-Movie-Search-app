//
//  UserReviewsViewController.swift
//  Movie Category Search
//
//  Created by Aleksandr Glushko on 12.09.19.
//  Copyright © 2019 tardis. All rights reserved.
//

import UIKit

class UserReviewsViewController: UITableViewController {
    
    lazy var backButton = UIButton()
    var characters = ["Link", "Zelda", "Gendalf", "Frodo"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.backButton = UIButton(type: .roundedRect)
        self.backButton.frame = CGRect(x: 20, y: 40, width: 80, height: 50)
        self.backButton.setTitle("Back", for: .normal)
        self.backButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        self.backButton.layer.cornerRadius = 10
        self.backButton.backgroundColor = UIColor.white
        self.backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        self.view.addSubview(self.backButton)
        
    }
    
    @objc func backButtonPressed(_ sender: Any){
        // get the array of the curren controllers
        var currentControllerArray = self.navigationController?.viewControllers
        
        // delete the last one
        currentControllerArray?.removeLast()
        
        // set the previous controller as the present one
        if let newController = currentControllerArray{
            self.navigationController?.viewControllers = newController
        }
    }
}
