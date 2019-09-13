//
//  OverviewCell.swift
//  Movie Category Search
//
//  Created by Aleksandr Glushko on 12.09.19.
//  Copyright © 2019 tardis. All rights reserved.
//

import Foundation
import UIKit

class OverviewCell: UITableViewCell {
    
    //var link: HomeTableViewController?
    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        // backgroundColor = .red
//        let starButton = UIButton(type: .system)
//        starButton.setImage(UIImage(named: "fav_star.png"), for: .normal)
//        starButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
//
//        starButton.tintColor = .red
//        starButton.addTarget(self, action: #selector(handleMarkAsFav), for: .touchUpInside)
//        accessoryView = starButton
//    }
    
//    @objc private func handleMarkAsFav() {
//        link?.someMethodWantToCall(cell: self)
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
