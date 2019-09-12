//
//  CommentsViewController.swift
//  Movie Category Search
//
//  Created by Aleksandr Glushko on 12.09.19.
//  Copyright © 2019 tardis. All rights reserved.
//

import UIKit

struct cellData {
    var opened = Bool()
    var title = String()
    var sectionData = [String]()
}

class CommentsViewController: UIViewController {
    
    lazy var backButton = UIButton()
    var tableView = UITableView()
    var tableViewData = [cellData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewData = [cellData(opened: false, title: "Cell1", sectionData: ["Cell1", "Cell2", "Cell3"]),
        cellData(opened: false, title: "Cell1", sectionData: ["Cell1", "Cell2", "Cell3"]),
        cellData(opened: false, title: "Cell1", sectionData: ["Cell1", "Cell2", "Cell3"])]
        
        // set back button
        self.backButton = UIButton(type: .roundedRect)
        self.backButton.frame = CGRect(x: 20, y: 50, width: 80, height: 50)
        self.backButton.setTitle("Back", for: .normal)
        self.backButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        self.backButton.layer.cornerRadius = 10
        self.backButton.backgroundColor = UIColor.white
        self.backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        self.view.addSubview(self.backButton)
        
        // set table view
        self.tableView.frame = CGRect(x: 0, y: 120, width: self.view.frame.width, height: self.view.frame.height-120)
        self.tableView.backgroundColor = UIColor.white
        // self.tableView.delegate = self
        //self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        
        self.tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
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
}
extension CommentsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened == true {
            return tableViewData[section].sectionData.count + 1
        } else { return 1 }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {fatalError("Unable to create cell")}
        let dataIndex = indexPath.row - 1
        if indexPath.row == 0 {
            
            cell.textLabel?.text = self.tableViewData[indexPath.section].title
            return cell
        } else {
            
            cell.textLabel?.text = self.tableViewData[indexPath.section].sectionData[dataIndex]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if tableViewData[indexPath.section].opened == true {
                tableViewData[indexPath.section].opened = false
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            } else {
                tableViewData[indexPath.section].opened = true
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}

