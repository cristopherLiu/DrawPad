//
//  DrawVC.swift
//  Drawing
//
//  Created by 劉紘任 on 2020/6/8.
//  Copyright © 2020 劉紘任. All rights reserved.
//

import UIKit

class DrawVC: UIViewController {
  
  let drawingView: DrawingView = {
    let view = DrawingView()
    view.bkgImage = UIColor.white.toImage()!
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  lazy var black: UIButton = {
    let button = UIButton()
    button.layer.cornerRadius = 24
    button.clipsToBounds = true
    button.setBackgroundImage(UIColor.black.toImage(CGSize(width: 48, height: 48)), for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(setColor), for: .touchUpInside)
    return button
  }()
  
  lazy var red: UIButton = {
    let button = UIButton()
    button.layer.cornerRadius = 24
    button.clipsToBounds = true
    button.setBackgroundImage(UIColor.red.toImage(CGSize(width: 48, height: 48)), for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(setColor), for: .touchUpInside)
    return button
  }()
  
  lazy var blue: UIButton = {
    let button = UIButton()
    button.layer.cornerRadius = 24
    button.clipsToBounds = true
    button.setBackgroundImage(UIColor.blue.toImage(CGSize(width: 48, height: 48)), for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(setColor), for: .touchUpInside)
    return button
  }()
  
  lazy var green: UIButton = {
    let button = UIButton()
    button.layer.cornerRadius = 24
    button.clipsToBounds = true
    button.setBackgroundImage(UIColor.green.toImage(CGSize(width: 48, height: 48)), for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(setColor), for: .touchUpInside)
    return button
  }()
  
  lazy var white: UIButton = {
    let button = UIButton()
    button.layer.borderWidth = 1
    button.layer.cornerRadius = 24
    button.clipsToBounds = true
    button.setImage(UIColor.white.toImage(CGSize(width: 48, height: 48)), for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(setColor), for: .touchUpInside)
    return button
  }()
  
  lazy var undo: UIButton = {
    let button = UIButton()
    button.layer.borderWidth = 1
    button.layer.cornerRadius = 24
    button.layer.borderColor = UIColor.black.cgColor
    button.clipsToBounds = true
    button.setTitle("退一步", for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.setBackgroundImage(UIColor.white.toImage(), for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(toUndo), for: .touchUpInside)
    return button
  }()
  
  lazy var clear: UIButton = {
    let button = UIButton()
    button.layer.borderWidth = 1
    button.layer.cornerRadius = 24
    button.layer.borderColor = UIColor.black.cgColor
    button.clipsToBounds = true
    button.setTitle("清空", for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.setBackgroundImage(UIColor.white.toImage(), for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(toClear), for: .touchUpInside)
    return button
  }()
  
  lazy var lineWidthSlider: UISlider = {
    let view = UISlider()
    view.minimumValue = 1
    view.maximumValue = 10
    view.value = Float(self.drawingView.lineWidth)
    view.isContinuous = false
    view.translatesAutoresizingMaskIntoConstraints = false
    view.addTarget(self, action: #selector(lineWidthChange), for: .valueChanged)
    return view
  }()
  
  lazy var lineWidthLabel: UILabel = {
    let label = UILabel()
    label.text = "粗細:\(self.drawingView.lineWidth.description)"
    label.font = UIFont.systemFont(ofSize: 16)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy var opacitySlider: UISlider = {
    let view = UISlider()
    view.minimumValue = 0.1
    view.maximumValue = 1
    view.value = self.drawingView.opacity
    view.isContinuous = false
    view.translatesAutoresizingMaskIntoConstraints = false
    view.addTarget(self, action: #selector(opacityChange), for: .valueChanged)
    return view
  }()
  
  lazy var opacityLabel: UILabel = {
    let label = UILabel()
    label.text = self.opacity
    label.font = UIFont.systemFont(ofSize: 16)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  var opacity: String {
    get{
      return "透明:\(self.drawingView.opacity.description)"
    }
    set{
      self.drawingView.opacity = Float(newValue) ?? 1
    }
  }
  
  var lineWidth: String {
    get{
      return "粗細:\(self.drawingView.lineWidth.description)"
    }
    set{
      let width = Float(newValue) ?? 0
      self.drawingView.lineWidth = CGFloat(width)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.lightGray
    
    let stackView = UIStackView(arrangedSubviews: [
      black,
      red,
      blue,
      green,
      white,
    ])
    stackView.distribution = .equalCentering
    stackView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(stackView)
    
    view.addSubview(undo)
    view.addSubview(clear)
    view.addSubview(lineWidthSlider)
    view.addSubview(lineWidthLabel)
    view.addSubview(opacitySlider)
    view.addSubview(opacityLabel)
    view.addSubview(drawingView)
    
    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      stackView.widthAnchor.constraint(equalToConstant: 48 * 5 + 8 * 4),
      stackView.heightAnchor.constraint(equalToConstant: 48),
      stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      
      undo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      undo.heightAnchor.constraint(equalToConstant: 48),
      undo.widthAnchor.constraint(equalToConstant: 100),
      undo.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8),
      undo.bottomAnchor.constraint(equalTo: lineWidthSlider.topAnchor, constant: -8),
      
      clear.leadingAnchor.constraint(equalTo: undo.trailingAnchor, constant: 8),
      clear.heightAnchor.constraint(equalToConstant: 48),
      clear.widthAnchor.constraint(equalToConstant: 100),
      clear.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8),
      clear.bottomAnchor.constraint(equalTo: lineWidthSlider.topAnchor, constant: -8),
      
      lineWidthSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//      lineWidth.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      lineWidthSlider.bottomAnchor.constraint(equalTo: opacitySlider.topAnchor, constant: -8),
      
      lineWidthLabel.leadingAnchor.constraint(equalTo: lineWidthSlider.trailingAnchor, constant: 8),
      lineWidthLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      lineWidthLabel.topAnchor.constraint(equalTo: lineWidthSlider.topAnchor),
      lineWidthLabel.bottomAnchor.constraint(equalTo: lineWidthSlider.bottomAnchor),
      
      opacitySlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//      opacity.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      opacitySlider.bottomAnchor.constraint(equalTo: drawingView.topAnchor, constant: -8),
      
      opacityLabel.leadingAnchor.constraint(equalTo: opacitySlider.trailingAnchor, constant: 8),
      opacityLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      opacityLabel.topAnchor.constraint(equalTo: opacitySlider.topAnchor),
      opacityLabel.bottomAnchor.constraint(equalTo: opacitySlider.bottomAnchor),
      
      drawingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      drawingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      drawingView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
    ])
  }
  
  @objc func setColor(_ sender: UIButton) {
    switch sender {
    case black:
      drawingView.lineType = .DRAW
      drawingView.color = .black
    case red:
      drawingView.lineType = .DRAW
      drawingView.color = .red
    case blue:
      drawingView.lineType = .DRAW
      drawingView.color = .blue
    case green:
      drawingView.lineType = .DRAW
      drawingView.color = .green
    case white:
      drawingView.lineType = .ERASE
      drawingView.color = .white
    default:
      return
    }
  }
  
  @objc func toClear() {
    drawingView.clear()
  }
  
  @objc func toUndo() {
    drawingView.undo()
  }
  
  @IBAction func lineWidthChange(_ sender: UISlider) {
    let str = String(format: "%.0f", Float(sender.value))
    self.lineWidth = str
    sender.setValue(Float(str) ?? 0, animated: true)
    lineWidthLabel.text = self.lineWidth
  }
  
  @IBAction func opacityChange(_ sender: UISlider) {
    let str = String(format: "%.1f", Float(sender.value))
    self.opacity = str
    sender.setValue(Float(str) ?? 0, animated: true)
    opacityLabel.text = self.opacity
  }
}
