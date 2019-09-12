//
//  MoviePageViewController.swift
//  Movie Category Search
//
//  Created by Aleksandr Glushko on 09.09.19.
//  Copyright © 2019 tardis. All rights reserved.
//

import UIKit
import AFNetworking

class MoviePageViewController: UIViewController {
    
    lazy var backButton = UIButton()
    lazy var commentsButton = UIButton()
    lazy var movieImageView = UIImageView()
    lazy var movieTitleLabel = UILabel()
    lazy var movieTitle = String()
    lazy var rateLabel = UILabel()
    lazy var aboutMovie = UITextView()
    lazy var movieID = String()
    lazy var commentsLabel = UILabel()
    
    lazy var tableViewComments = UITableView()
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentSize.height = 2000
        //view.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpg")!)
        return view
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set background
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpg")!)
        
//        self.view.addSubview(self.scrollView)
//        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        // set picture of the movie
        self.movieImageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height / 2)
        self.movieImageView.contentMode = .scaleAspectFill
        self.movieImageView.layer.cornerRadius = 20
        self.view.addSubview(self.movieImageView)
        
        // set movieTitle
        self.movieTitleLabel.frame = CGRect(x: 0, y: self.view.frame.height/2 + 50, width: self.view.frame.width, height: 40)
        self.movieTitleLabel.backgroundColor = UIColorFromRGB(rgbValue: 0x7fa3b0)
        self.movieTitleLabel.layer.cornerRadius = 10
        self.movieTitleLabel.text = "\(movieTitle)"
        self.movieTitleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        self.movieTitleLabel.textColor = UIColor.white
        self.view.addSubview(self.movieTitleLabel)
        
        // set movieRate
        self.rateLabel.frame = CGRect(x: 0, y: self.view.frame.height/2 + 85, width: self.view.frame.width, height: 40)
        self.rateLabel.backgroundColor = UIColorFromRGB(rgbValue: 0x7fa3b0)
        self.rateLabel.layer.cornerRadius = 10
        self.rateLabel.textAlignment = .left
        self.rateLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.rateLabel.textColor = UIColor.white
        self.view.addSubview(self.rateLabel)
        
        // set movie About
        self.aboutMovie.frame = CGRect(x: 0, y: self.view.frame.height/2 + 120, width: self.view.frame.width, height: 200)
        self.aboutMovie.backgroundColor = UIColor.white
        //self.aboutMovie.font = UIFont.systemFont(ofSize: 22)
        let fixedWidth = aboutMovie.frame.size.width
        let newSize = aboutMovie.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        aboutMovie.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        aboutMovie.isScrollEnabled = false
        self.view.addSubview(self.aboutMovie)
        
        // set back button
        self.backButton = UIButton(type: .roundedRect)
        self.backButton.frame = CGRect(x: 20, y: 50, width: 80, height: 50)
        self.backButton.setTitle("Back", for: .normal)
        self.backButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        self.backButton.layer.cornerRadius = 10
        self.backButton.backgroundColor = UIColor.white
        self.backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        self.view.addSubview(self.backButton)
        
//        // set comments label
//        self.commentsLabel.frame = CGRect(x: 0, y: self.view.frame.height/2 + 120 + newSize.height, width: self.view.frame.width, height: 30)
//        self.commentsLabel.text = "Comments"
//        self.commentsLabel.backgroundColor = UIColor.white
//        self.commentsLabel.font = UIFont.boldSystemFont(ofSize: 24)
//        scrollView.addSubview(self.commentsLabel)
        
        // set comments table
        self.commentsButton = UIButton(type: .roundedRect)
        self.commentsButton.frame = CGRect(x: 0, y: self.view.frame.height/2 + 120 + newSize.height , width: self.view.frame.width, height: self.view.frame.height/2 - 120 - newSize.height)
        self.commentsButton.setTitle("Comments", for: .normal)
        self.commentsButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        self.commentsButton.backgroundColor = UIColor.white
        self.commentsButton.addTarget(self, action: #selector(commentsButtonPressed), for: .touchUpInside)
        self.view.addSubview(self.commentsButton)
        
    }
    
    // behavior when Back is pressed
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
    @objc func commentsButtonPressed(_ sender: Any) {
        //let commentsVC = CommentsViewController()
        //self.navigationController?.pushViewController(commentsVC, animated: true)
    }

    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
