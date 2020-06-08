//
//  UIView+Extension.swift
//  Drawing
//
//  Created by 劉紘任 on 2020/6/8.
//  Copyright © 2020 劉紘任. All rights reserved.
//

import UIKit

// https://stackoverflow.com/a/40953026/4488252
extension UIView {
  var screenShot: UIImage?  {
    let scale = UIScreen.main.scale
    UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale)
    if let context = UIGraphicsGetCurrentContext() {
      layer.render(in: context)
      let screenshot = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      return screenshot
    }
    return nil
  }
}
