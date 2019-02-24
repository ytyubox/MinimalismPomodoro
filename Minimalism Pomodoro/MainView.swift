//
//  MainView.swift
//  Minimalism Pomodoro
//
//  Created by 游宗諭 on 2019/2/24.
//  Copyright © 2019 游宗諭. All rights reserved.
//

import UIKit

class MainView: UIView {

  let picker:HoriPicker = {
    let picker = HoriPicker()
    picker.backgroundColor = .orange

    return picker
  }()

  let timeLabel:UILabel = {
    let label = UILabel()
    return label
  }()

  private func setDelegate() {
    picker.dataSource = picker
    picker.delegate = picker
  }

  func setup() {
    setupView()
    setDelegate()
  }

  fileprivate func setupPicker() {
    var transform = CGAffineTransform.identity
    transform = transform.rotated(by: .pi / -2)
    transform = transform.scaledBy(x: -1, y: 1)
    picker.transform = transform

    let frame = UIScreen.main.bounds
    let widthOffset:CGFloat = 100
    picker.frame = .init(x: 0 - widthOffset / 2,
                         y: frame.height / 2,
                         width: frame.width  + widthOffset,
                         height: frame.height / 4)
  }

  private func setupLabel(){
    
  }

  private func setupView(){
    backgroundColor = .gray

    addSubviews(picker,timeLabel)
    setupPicker()

  }

  weak var delegate:ViewController?

}
