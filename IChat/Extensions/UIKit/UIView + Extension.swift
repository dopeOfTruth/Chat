//
//  UIView + Extension.swift
//  IChat
//
//  Created by Михаил Красильник on 19.04.2021.
//

import UIKit

extension UIView {
    
    func applyGradients(cornerRadius: CGFloat) {
        self.backgroundColor = nil
        self.layoutIfNeeded()
        let gradientView = GradientView(from: .topTrailing, to: .bottomLeading, startColor: #colorLiteral(red: 0.7882352941, green: 0.631372549, blue: 0.9411764706, alpha: 1), endColor: #colorLiteral(red: 0.4784313725, green: 0.6980392157, blue: 0.9215686275, alpha: 1))
        
        if let grdientLayer = gradientView.layer.sublayers?.first as? CAGradientLayer {
            grdientLayer.frame = self.bounds
            grdientLayer.cornerRadius = cornerRadius
            self.layer.insertSublayer(grdientLayer, at: 0)
        }
    }
}
