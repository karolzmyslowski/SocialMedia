//
//  CircleView.swift
//  SocialMedia
//
//  Created by Karol Zmyslowski on 15.02.2018.
//  Copyright © 2018 Karol Zmyslowski. All rights reserved.
//

import UIKit

class CircleView: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 2, height: 2)
    }
    override func layoutSubviews() {
        layer.cornerRadius = self.frame.width / 2
    }

}
