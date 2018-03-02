//
//  FancyFT.swift
//  SocialMedia
//
//  Created by Karol Zmyslowski on 12.02.2018.
//  Copyright © 2018 Karol Zmyslowski. All rights reserved.
//

import UIKit

class FancyFT: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 0.6).cgColor
        layer.borderWidth = 2
     
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 5)
    }

}
