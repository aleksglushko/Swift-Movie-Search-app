//
//  MovieOverviewTableViewController.swift
//  Movie Category Search
//
//  Created by Aleksandr Glushko on 11.09.19.
//  Copyright © 2019 tardis. All rights reserved.
//

import UIKit

struct cellData {
    var opened = Bool()
    var title = String() // author name, rate, publication date
    var sectionData = [String]() // overview
}

class MovieOverviewTableViewController: UITableViewController {
    
    var tableViewData = [cellData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewData = [cellData(opened: false, title: "title1", sectionData: ["Cell1", "Cell2", "Cell3"]),
                         cellData(opened: false, title: "title2", sectionData: ["Cell1", "Cell2", "Cell3"]),
                         cellData(opened: false, title: "title3", sectionData: ["Cell1", "Cell2", "Cell3"]),
                         cellData(opened: false, title: "title4 ", sectionData: ["Cell1", "Cell2", "Cell3"])]
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return tableViewData.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if tableViewData[section].opened == true {
            return tableViewData[section].sectionData.count + 1
        } else {
            return 1        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataIndex = indexPath.row - 1
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "overviewCell") else {return UITableViewCell()}
            cell.textLabel?.text = tableViewData[indexPath.section].title
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "overviewCell") else {return UITableViewCell()}
            cell.textLabel?.text = tableViewData[indexPath.section].sectionData[dataIndex]
            return cell
        }
    }
 

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
    }

}
