//
//  CustomViews.swift
//  TidesMentors
//
//  Created by Chandler Long on 6/29/17.
//  Copyright © 2017 Chandler Long. All rights reserved.
//

import UIKit

let greyShadow: CGFloat = 120.0 / 255.0

class MentorImageRadius: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor = UIColor(red: greyShadow, green: greyShadow, blue: greyShadow, alpha: 0.6).cgColor
        layer.cornerRadius = 50
        clipsToBounds = true
    }
    
    override func layoutSubviews() {
        
    }
}

class ViewBoarder: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: greyShadow, green: greyShadow, blue: greyShadow, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.borderWidth = 3
        layer.borderColor = UIColor(red: 14.0/255, green: 122.0/255 , blue: 254.0/255, alpha: 1.0).cgColor
    }
    
}
