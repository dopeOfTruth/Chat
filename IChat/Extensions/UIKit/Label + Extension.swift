//
//  Label + Extension.swift
//  IChat
//
//  Created by Михаил Красильник on 14.04.2021.
//

import UIKit

extension UILabel {
    
    convenience init(text: String, font: UIFont? = .avenir20()) {
        self.init()
        
        self.text = text
        self.font = font 
    }
}
