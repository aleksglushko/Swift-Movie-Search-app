//
//  CommentsTableViewController.swift
//  Movie Category Search
//
//  Created by Aleksandr Glushko on 12.09.19.
//  Copyright © 2019 tardis. All rights reserved.
//

import UIKit

class CommentsTableViewController: UITableViewController {

    lazy var aboutMovie = UITextView()
    lazy var movieID = String()
    var overviewsDict: [NSDictionary]?
    var movieReviewsArray = [[String]]()
    var additionalComments = [[String]]()
    
    let cellId = "cellId:1"
    lazy var filePath = "Comments.txt"
    
    func readFromFile(filePath: String) -> [[String]]{
        let fileUrl = NSURL(fileURLWithPath: filePath)
        let data = NSArray(contentsOf: fileUrl as URL) as? [[String]] ?? [[String]]()
        print("\nRestored array: \(data)\n")
        return data
    }
    func saveToFile(filePath: String, data: [[String]]){
        let fileUrl = NSURL(fileURLWithPath: filePath)
        // Save to file
        (data as NSArray).write(to: fileUrl as URL, atomically: true)
        print("\nSaved array: \(data)\n")
    }
    
    @objc func handleAddOverview(){
        let popingUpWin = UIAlertController(title: "Add Comment", message: "", preferredStyle: .alert)
        popingUpWin.addTextField{ (textField : UITextField!) -> Void in
            textField.placeholder = "Enter your name"
            textField.frame = CGRect(x: 0, y: 0, width: 200, height: 30)
        }
        popingUpWin.addTextField{ (textField : UITextField!) -> Void in
            textField.placeholder = "enter your opinion"
            textField.frame = CGRect(x: 0, y: 0, width: 200, height: 30)
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default){ (action) in
            let author = popingUpWin.textFields![0] as UITextField
            let comment = popingUpWin.textFields![1] as UITextField
            self.movieReviewsArray.append([author.text!, comment.text!])
            var oldData = self.readFromFile(filePath: self.filePath)
            oldData.append([author.text!, comment.text!])
            self.saveToFile(filePath: self.filePath, data: oldData)
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) {
            (action : UIAlertAction!) -> Void in }

        popingUpWin.addAction(saveAction)
        popingUpWin.addAction(cancelAction)
        self.present(popingUpWin, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    override func viewDidLoad() {
        self.movieReviewsArray = self.readFromFile(filePath: self.filePath) ?? [[String]]()
        super.viewDidLoad()
        fetchOverviews(movieID: movieID)
        self.navigationController?.setNavigationBarHidden(false, animated: true)

        // set nav button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Overview", style: .plain, target: self, action: #selector(handleAddOverview))
        
        // set nav title
        navigationItem.title = "User Reviews"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // set cell delegation
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.dataSource = self
        tableView.isScrollEnabled = true
        //tableView.rowHeight = UITableView.automaticDimension
        //tableView.estimatedRowHeight = 300.0
        

    }
    
    func fetchOverviews(movieID: String){
        let apiKey = "d372b5fd608c81066dbd0892b2faeb35"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/\(movieID)/reviews?api_key=\(apiKey)&language=en-US&page=1")
        
        let request = NSURLRequest(
            url: url! as URL,
            cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate: nil,
            delegateQueue: OperationQueue.main
        )
        
        let task: URLSessionDataTask = session.dataTask(
            with: request as URLRequest, completionHandler: {
                (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! JSONSerialization.jsonObject(
                        with: data, options: []) as? NSDictionary {
                        
                        self.overviewsDict = responseDictionary["results"] as? [NSDictionary]
                        var i = 0
                        while i < self.overviewsDict!.count {
                            let author = self.overviewsDict![i]["author"] as! String
                            let review = self.overviewsDict![i]["content"] as! String
                           
                            if !self.movieReviewsArray.contains([author, review]) {
                                self.movieReviewsArray.append([author, review])
                                i += 1
                            }
                        }
                        self.tableView.reloadData()
                    }
                }
        }
        )
        task.resume()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        print("Section: \(section)")
        let author = self.movieReviewsArray[section][0]
        print("Section: \(section) - author: \(author)")
        
        let label = UILabel()
        label.text = "     Author: \(author)"
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.lightGray
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 34
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        print(self.movieReviewsArray)
        print("Amount of comments: \(self.movieReviewsArray.count)")
        return self.movieReviewsArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let review = self.movieReviewsArray[indexPath.section][1]
        print("Section: \(indexPath.section) - \(review)")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let textView: UITextView = UITextView(frame: CGRect(x: 0, y: 0, width: cell.frame.width, height: 100))  // Set frames as per requirements
        textView.isScrollEnabled = true
        textView.translatesAutoresizingMaskIntoConstraints = false

        textView.font = .systemFont(ofSize: 16)
        textView.textAlignment = NSTextAlignment.left
        textView.text = review
        textView.sizeToFit()
        cell.contentView.addSubview(textView)
        
        //cell.textLabel?.text = review
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300// UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
