//
//  UIImage + Extension.swift
//  IChat
//
//  Created by Михаил Красильник on 25.04.2021.
//

import UIKit

extension UIImage {
    
    var scaledToSafeUploadSize: UIImage? {
        
        let maxImageSideLenght: CGFloat = 480
        
        let largeSide = max(size.width, size.height)
        let rationScale = largeSide > maxImageSideLenght ? largeSide / maxImageSideLenght : 1
        let newImageSize = CGSize(width: size.width / rationScale, height: size.height / rationScale)
        
        return image(scaleTo: newImageSize)
    }
    
    func image(scaleTo size: CGSize) -> UIImage? {
        defer {
            UIGraphicsEndImageContext()
        }
        
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        draw(in: CGRect(origin: .zero, size: size))
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
