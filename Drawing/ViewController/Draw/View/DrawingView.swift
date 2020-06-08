//
//  DrawingView.swift
//  Drawing
//
//  Created by 劉紘任 on 2020/6/8.
//  Copyright © 2020 劉紘任. All rights reserved.
//

import UIKit

enum LineType: Int {
  case DRAW
  case ERASE
}

class DrawingView: UIView {
  
  var lineType: LineType = .DRAW // 種類
  var color: UIColor = UIColor.black
  var opacity: Float = 1.0
  var lineWidth: CGFloat = 4.0
  
  fileprivate var path =  UIBezierPath()
  fileprivate var previousTouchPoint = CGPoint.zero
  fileprivate var maskLayer: CAShapeLayer!
  
  // 背景圖
  var bkgImage: UIImage = UIImage() {
    didSet {
      updateBkgImage()
    }
  }
  
  fileprivate func updateBkgImage() -> Void {
    
    if layer.sublayers == nil {
      let l = CALayer()
      layer.addSublayer(l)
    }
    guard let layers = layer.sublayers else { return }
    
    for l in layers {
      if let _ = l as? CAShapeLayer {
    
      } else {
        l.contents = bkgImage.cgImage
      }
    }
    setNeedsDisplay()
  }
  
  // 回上一步
  func undo() {
    guard let n = layer.sublayers?.count, n > 1 else { return }
    _ = layer.sublayers?.popLast()
  }
  
  // 清空
  func clear() {
    
    guard let layers = layer.sublayers else { return }
    for l in layers {
      if let line = l as? CAShapeLayer {
        line.removeFromSuperlayer()
      } else {
        // 背景圖 不處理
      }
    }
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    if let location = touches.first?.location(in: self) {
      
      if self.lineType == LineType.DRAW {
        _ = addDrawLayer()
      } else {
        self.maskLayer = addEraserLayer()
      }
      
      path.removeAllPoints() // 清空曲線
      previousTouchPoint = location
    }
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesMoved(touches, with: event)
    if let location = touches.first?.location(in: self) {
      path.move(to: location)
      path.addLine(to: previousTouchPoint)
      previousTouchPoint = location
      
      if let lastLayer = self.layer.sublayers?.last {
        if let lastShapeLayer = lastLayer as? CAShapeLayer {
          lastShapeLayer.path = path.cgPath
        } else {
          self.maskLayer.path = path.cgPath
          lastLayer.mask = self.maskLayer
        }
      }
    }
  }
  
  fileprivate func addDrawLayer()-> CAShapeLayer {
    let newLayer = CAShapeLayer()
    newLayer.lineCap = .round
    newLayer.lineWidth = self.lineWidth
    newLayer.opacity = self.opacity
    newLayer.strokeColor = self.color.cgColor
    newLayer.fillColor = UIColor.clear.cgColor
    
    self.layer.addSublayer(newLayer)
    return newLayer
  }
  
  fileprivate func addEraserLayer()-> CAShapeLayer {
    
    let maskLayer = CAShapeLayer()
    maskLayer.lineCap = .round
    maskLayer.lineWidth = self.lineWidth
    maskLayer.strokeColor = UIColor.black.cgColor
    maskLayer.fillColor = UIColor.clear.cgColor
    
    let newLayer = CALayer()
    newLayer.contents = self.bkgImage.cgImage
    newLayer.opacity = self.opacity
    newLayer.mask = maskLayer
    
    self.layer.addSublayer(newLayer)
    return maskLayer
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    // update layer frames
    if let layers = layer.sublayers {
      for l in layers {
        l.frame = bounds
      }
    }
  }
}
