//
//  MainView.swift
//  Minimalism Pomodoro
//
//  Created by 游宗諭 on 2019/2/24.
//  Copyright © 2019 游宗諭. All rights reserved.
//

import UIKit

class MainView: UIView {
  var selectedtime = (w:15,r:3,c:3) {didSet{
    workTimeLabel.attributedText
      = makeAttributedString(w_s: selectedtime.w * 60,
                             r_s: selectedtime.r * 60,
                             c: selectedtime.c)

      commandButtons[0].isEnabled = !(selectedtime.w == 0 && selectedtime.r == 0)
    }}


  let picker = TimePickerView()
 


  lazy var workTimeLabel:UILabel = {
    let label = UILabel()
//    label.text = "Work: 15:00\n03:00"
    label.attributedText = makeAttributedString(w_s: 15 * 60, r_s: 3 * 60,c:3)
//    label.textAlignment = .right
//    label.font = UIFont.boldSystemFont(ofSize: 50)
    label.numberOfLines = 0
    return label
  }()

  func makeAttributedString(w_s:Int,r_s:Int,c:Int)->NSMutableAttributedString {
    let work = NSMutableAttributedString(string: String(format: "\tWork: %02d:%02d", w_s / 60, w_s % 60) , attributes: [
      .font: UIFont.boldSystemFont(ofSize: 40)
      ])
    let rest = NSAttributedString(string: String(format: "\n\t\tRest: %02d:%02d", r_s / 60, r_s % 60), attributes: [
      .font:UIFont.systemFont(ofSize: 30),
      ])
    let cycle = NSAttributedString(string: String(format: "\n\t\tcycle: %d", c), attributes: [
      .font:UIFont.systemFont(ofSize: 20),
      ])

    work.append(rest)
    work.append(cycle)
    return work
  }

  let commandButtons:[UIButton] = (0...1).map{
      let button = UIButton(type: UIButton.ButtonType.custom)
      button.tag = $0
    button.setTitle(Theme.commandName[$0], for: .normal)
    button.addTarget(self, action: #selector(command), for: .touchUpInside)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
    button.layer.borderWidth = 1
    button.layer.cornerRadius = 50 / 2
    button.setTitleColor(.gray, for: UIControl.State.disabled)
      return button
    }
  let settingButton:UIButton = {
    let button = UIButton(type: UIButton.ButtonType.custom)
    button.setTitle(Theme.commandName[2], for: UIControl.State.normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
    button.addTarget(self, action: #selector(command), for: .touchUpInside)
    button.layer.borderWidth = 1
    return button
  }()


  let helpButton:UIButton = {
    let button = UIButton(type: UIButton.ButtonType.custom)
    button.setTitle(Theme.commandName[7], for: UIControl.State.normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
    button.addTarget(self, action: #selector(command), for: .touchUpInside)
    button.layer.borderWidth = 1
    return button
  }()


  //FIXME: <#For what#>

  //MARK: -



  func setup() {
    setupView()
    setDelegate()
  }

  private func setupView(){


    addSubviews(picker, workTimeLabel,settingButton,commandButtons[0],commandButtons[1],helpButton)
    setupPicker()
    setupLabel()
    setupTheme()
    setupButtons()

  }

  private func setDelegate() {
    picker.dataSource = picker
    picker.delegate = picker
  }

//MARK:-

  func setupTheme() {
    workTimeLabel.textColor = Theme.foregroundColor

    picker.setupTheme()
    backgroundColor = Theme.backgroundColor
    [0,1].forEach{
      commandButtons[$0].setTitleColor(Theme.foregroundColor, for: .normal)
      commandButtons[$0].backgroundColor = Theme.mediumColor
      commandButtons[$0].layer.borderColor = Theme.foregroundColor.cgColor
    }
//    commandButtons[1].isEnabled = false
    [settingButton,helpButton].forEach{
      $0.layer.borderColor = Theme.foregroundColor.cgColor
      $0.setTitleColor(Theme.foregroundColor, for: .normal)
    }
  }



  fileprivate func setupPicker() {
    var transform = CGAffineTransform.identity
    transform = transform.rotated(by: .pi / -2)
    transform = transform.scaledBy(x: -1, y: 1)
    picker.transform = transform


    let widthOffset:CGFloat = 100
    picker.frame = .init(x: 0 - widthOffset / 2,
                         y: screenFrame.height / 2 - 70,
                         width: screenFrame.width  + widthOffset,
                         height: screenFrame.height / 3)

  }
  private func setupLabel(){

    workTimeLabel.frame = .init(x: 0,
                         y: screenFrame.height / 4 - screenFrame.height / 16,
                         width: screenFrame.width ,
                         height: screenFrame.height / 8)
    let maxHeight = CGFloat.infinity
    let rect = workTimeLabel.attributedText?.boundingRect (with: CGSize(width: screenFrame.width, height:  maxHeight),
                                                           options: .usesLineFragmentOrigin, context: nil)
    var frame = workTimeLabel.frame
    frame.size.height = rect!.size.height
    workTimeLabel.center.x = screenFrame.width / 4
    workTimeLabel.frame = frame
//    workTimeLabel.sizeToFit()


  }

  fileprivate func setupButtons() {
    settingButton.frame = .init(x: 25, y: 25, width: 50, height: 50)
    settingButton.layer.cornerRadius = 50 / 2

    helpButton.frame = .init(x: screenFrame.width  - 25 - 50, y: 25, width: 50, height: 50)
    helpButton.layer.cornerRadius = 50 / 2



//    commandButtons[0].frame = .init(x: 0 , y: screenFrame.height / 6 * 5, width: screenFrame.width / 2 - 10, height: screenFrame.height / 6)
//    commandButtons[1].frame = .init(x: screenFrame.width / 2 + 10, y: screenFrame.height / 6 * 5, width: screenFrame.width / 2 - 10, height: screenFrame.height / 6)
    commandButtons[0].frame = .init(x: 0 , y: screenFrame.height / 6 * 5, width: screenFrame.width / 2 - 10, height: 50)
    commandButtons[1].frame = .init(x: screenFrame.width / 2 + 10, y: screenFrame.height / 6 * 5, width: screenFrame.width / 2 - 10, height: 50)



  }

  lazy  var screenFrame = UIScreen.main.bounds
  weak var delegate:ViewController?


  //MARK:-

  func pickerSelect(_ cr:[Int], animated: Bool = true) {
    cr.enumerated().forEach{
      picker.selectRow($1, inComponent: $0, animated: animated)
    }
    picker.reloadComponent(1)
  }
  func updateLabel(w_time_s:Int,r_time_s:Int,cycle:Int){
    workTimeLabel.attributedText = makeAttributedString(w_s: w_time_s, r_s: r_time_s,c: cycle)
  }

  func resetUI(to p:Pomodoro){
    updateLabel(w_time_s: p.workTime_s, r_time_s: p.restTime_s, cycle: p.cycle)
    pickerSelect([p.workTime_s / 60,p.restTime_s / 60,p.cycle])
  }
}


//MARK: -

extension MainView {
  @objc func command(_ sender:UIButton){
    guard let title = sender.currentTitle else {return}
    UNCenter.requestAuthorization()
    //    UNCenter.sentUN(delay: 5, message: "press" + title)
    delegate?.handler(for: Command.init(for: title))
    switch title {
    case Theme.commandName[0]:
      sender.setTitle(Theme.commandName[3], for: .normal)
    case Theme.commandName[3]:
      sender.setTitle(Theme.commandName[6], for: .normal)
    case Theme.commandName[6]:
      sender.setTitle(Theme.commandName[3], for: .normal)
    case Theme.commandName[1]:
      commandButtons[0].setTitle(Theme.commandName[0], for: .normal)
    default:
      break
    }
  }
}


