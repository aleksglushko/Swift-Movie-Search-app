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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
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
        
        // set comments table
        self.commentsButton = UIButton(type: .roundedRect)
        self.commentsButton.frame = CGRect(x: 0, y: self.view.frame.height/2 + 120 + newSize.height , width: self.view.frame.width, height: self.view.frame.height/2 - 120 - newSize.height)
        self.commentsButton.setTitle("User Reviews", for: .normal)
        self.commentsButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        self.commentsButton.backgroundColor = UIColor.white
        self.commentsButton.addTarget(self, action: #selector(commentsButtonPressed), for: .touchUpInside)
        self.view.addSubview(self.commentsButton)
        
    }
    
    @objc func commentsButtonPressed(_ sender: Any) {
        let commentsVC = CommentsTableViewController()
        self.navigationController?.pushViewController(commentsVC, animated: true)
        
        commentsVC.movieID = movieID
        commentsVC.aboutMovie = aboutMovie
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
