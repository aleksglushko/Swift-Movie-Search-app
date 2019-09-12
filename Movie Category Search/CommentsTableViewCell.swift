//
//  CommentsTableViewCell.swift
//  Movie Category Search
//
//  Created by Aleksandr Glushko on 11.09.19.
//  Copyright © 2019 tardis. All rights reserved.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {
    
    lazy var backView: UIView = {
        let view = UIView(frame: CGRect(x: 10, y: 4, width: self.frame.width - 20, height: 200))
        view.backgroundColor = UIColor.clear
        
        return view
    }()
    
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 116, y: 8, width: backView.frame.width - 116, height: 30))
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 18)
        
        return label
    }()
    
    lazy var comment: UILabel = {
        let label = UILabel(frame: CGRect(x: 116, y: 42, width: backView.frame.width - 116, height: 30))
        label.textAlignment = .left
        
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = UIColor.clear
        backView.layer.cornerRadius = 5
        backView.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        addSubview(backView)
        backView.addSubview(titleLabel)
        backView.addSubview(comment)
    }

}
