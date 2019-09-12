//
//  ReviewesTableViewCell.swift
//  Movie Category Search
//
//  Created by Aleksandr Glushko on 10.09.19.
//  Copyright © 2019 tardis. All rights reserved.
//

import UIKit

class ReviewesTableViewCell: UITableViewCell {

    lazy var backView: UIView = {
        let view = UIView(frame: CGRect(x: 10, y: 4, width: self.frame.width - 20, height: 200))
        view.backgroundColor = UIColor.clear
        
        return view
    }()
    
    lazy var mainInfoLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 2, y: 2, width: backView.frame.width - 2, height: 30))
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 18)
        
        return label
    }()
    
    lazy var overviewField: UITextView = {
        let field = UITextView()
        field.frame = CGRect(x: 0, y: 32, width: backView.frame.width, height: 200)
        field.backgroundColor = UIColor.white
        //self.aboutMovie.font = UIFont.systemFont(ofSize: 22)
        let fixedWidth = field.frame.size.width
        let newSize = field.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        field.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        field.isScrollEnabled = false
        
        return field
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
        backView.addSubview(mainInfoLabel)
        backView.addSubview(overviewField)
    }
    
}
