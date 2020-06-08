//
//  UIColor+Extension.swift
//  Drawing
//
//  Created by 劉紘任 on 2020/6/8.
//  Copyright © 2020 劉紘任. All rights reserved.
//

import UIKit

extension UIColor {
  
  convenience init(red: Int, green: Int, blue: Int) {
    assert(red >= 0 && red <= 255, "Invalid red component")
    assert(green >= 0 && green <= 255, "Invalid green component")
    assert(blue >= 0 && blue <= 255, "Invalid blue component")
    
    self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
  }
  
  convenience init(rgb: Int) {
    self.init(
      red: (rgb >> 16) & 0xFF,
      green: (rgb >> 8) & 0xFF,
      blue: rgb & 0xFF
    )
  }
  
  func toImage(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
    
    let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
    UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
    
    let context = UIGraphicsGetCurrentContext()
    
    self.setFill()
    context!.fill(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image
  }
}
