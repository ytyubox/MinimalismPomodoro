//
//  MainView.swift
//  Minimalism Pomodoro
//
//  Created by 游宗諭 on 2019/2/24.
//  Copyright © 2019 游宗諭. All rights reserved.
//

import UIKit

class MainView: UIView {
  var selectedtime = (w:15,r:0) {didSet{
    timeLabel.text = String(format: "%02d:%02d", selectedtime.w,selectedtime.r)
    }}

  let picker:TimePickerView = {
    let picker = TimePickerView()
    picker.showsSelectionIndicator = true
   
    return picker
  }()


  let timeLabel:UILabel = {
    let label = UILabel()
    label.text = "15:00"
    label.textAlignment = .center
    label.font = UIFont.boldSystemFont(ofSize: 50)

    return label
  }()
  let commandButton:[UIButton] = (0...1).map{
      let button = UIButton(type: UIButton.ButtonType.custom)
      button.tag = $0
    button.addTarget(button, action: #selector(command), for: .touchUpInside)
      return button
    }

  private func setDelegate() {
    picker.dataSource = picker
    picker.delegate = picker
  }

  func setupTheme() {
    timeLabel.textColor = Theme.foregroundColor
    picker.backgroundColor = Theme.backgroundColor
    backgroundColor = Theme.backgroundColor
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


    let widthOffset:CGFloat = 100
    picker.frame = .init(x: 0 - widthOffset / 2,
                         y: screenFrame.height / 2,
                         width: screenFrame.width  + widthOffset,
                         height: screenFrame.height / 3)
  }
   let screenFrame = UIScreen.main.bounds

  private func setupLabel(){

    timeLabel.frame = .init(x: 0,
                         y: screenFrame.height / 4,
                         width: screenFrame.width ,
                         height: screenFrame.height / 4)
  }

  private func setupView(){


    addSubviews(picker,timeLabel)
    setupPicker()
    setupLabel()
    setupTheme()

  }

  weak var delegate:ViewController?

}

extension MainView {
  @objc func command(_ sender:UIButton){
    guard let title = sender.currentTitle else {return}
    delegate?.handler(for: Command.init(for: title))
  }
}


