//
//  CustomTableViewCell.swift
//  Movie Category Search
//
//  Created by Aleksandr Glushko on 08.09.19.
//  Copyright © 2019 tardis. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell, UISearchBarDelegate {

    lazy var backView: UIView = {
        let view = UIView(frame: CGRect(x: 10, y: 4, width: self.frame.width - 20, height: 200))
        view.backgroundColor = UIColor.clear
        
        return view
    }()
    
    lazy var movieImage: UIImageView = {
        let movieImage = UIImageView(frame: CGRect(x: 4, y: 4, width: 108, height: 108))
        movieImage.contentMode = .scaleAspectFill
        
        return movieImage
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 116, y: 8, width: backView.frame.width - 116, height: 30))
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 18)
        
        return label
    }()
    
    lazy var rateLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 116, y: 42, width: backView.frame.width - 116, height: 30))
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var genreLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 116, y: 72, width: backView.frame.width - 116, height: 30))
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
        movieImage.layer.cornerRadius = 5
        movieImage.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        addSubview(backView)
        backView.addSubview(movieImage)
        backView.addSubview(titleLabel)
        backView.addSubview(rateLabel)
        backView.addSubview(genreLabel)
    }

}
