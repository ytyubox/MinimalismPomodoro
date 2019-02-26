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
      commandButtons[0].isEnabled = !(selectedtime.w == 0 && selectedtime.r == 0)
    }}

  let picker = TimePickerView()

  let timeLabel:UILabel = {
    let label = UILabel()
    label.text = "15:00"
    label.textAlignment = .center
    label.font = UIFont.boldSystemFont(ofSize: 50)

    return label
  }()
  let commandButtons:[UIButton] = (0...1).map{
      let button = UIButton(type: UIButton.ButtonType.custom)
      button.tag = $0
    button.setTitle(Theme.commandName[$0], for: .normal)
    button.addTarget(self, action: #selector(command), for: .touchUpInside)
      return button
    }
  let settingButton:UIButton = {
    let button = UIButton(type: UIButton.ButtonType.custom)
    button.setTitle(Theme.commandName[2], for: UIControl.State.normal)
    button.addTarget(self, action: #selector(command), for: .touchUpInside)
    return button
  }()

  //MARK: -

  private func setDelegate() {
    picker.dataSource = picker
    picker.delegate = picker
  }

  func setupTheme() {
    timeLabel.textColor = Theme.foregroundColor
    picker.backgroundColor = Theme.backgroundColor
    backgroundColor = Theme.backgroundColor
    [0,1].forEach{
      commandButtons[$0].setTitleColor(Theme.foregroundColor, for: .normal)
      commandButtons[$0].backgroundColor = Theme.mediumColor
    }
    commandButtons[1].isEnabled = false
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
  private func setupLabel(){

    timeLabel.frame = .init(x: 0,
                         y: screenFrame.height / 4,
                         width: screenFrame.width ,
                         height: screenFrame.height / 4)
  }

  fileprivate func setupButtons() {
    settingButton.frame = .init(x: 0, y: 0, width: 50, height: 50)
    settingButton.layer.cornerRadius = 50 / 2

    commandButtons[0].frame = .init(x: 0 , y: screenFrame.height / 6 * 5, width: screenFrame.width / 2, height: screenFrame.height / 6)
    commandButtons[1].frame = .init(x: screenFrame.width / 2, y: screenFrame.height / 6 * 5, width: screenFrame.width / 2, height: screenFrame.height / 6)

  }

  private func setupView(){


    addSubviews(picker,timeLabel,settingButton,commandButtons[0],commandButtons[1])
    setupPicker()
    setupLabel()
    setupTheme()
    setupButtons()

  }
  lazy  var screenFrame = UIScreen.main.bounds
  weak var delegate:ViewController?

}

//MARK: -

extension MainView {
  @objc func command(_ sender:UIButton){
    guard let title = sender.currentTitle else {return}
    UNCenter.requestAuthorization()
    UNCenter.sentUN(delay: 5, message: "press" + title)
    delegate?.handler(for: Command.init(for: title))
    switch title {
    case Theme.commandName[0] :
      sender.setTitle(Theme.commandName[3], for: .normal)
    case Theme.commandName[3]:
      sender.setTitle(Theme.commandName[0], for: .normal)
    default:
      break
    }
  }
}


