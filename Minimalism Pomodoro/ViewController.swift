//
//  ViewController.swift
//  Minimalism Pomodoro
//
//  Created by 游宗諭 on 2019/2/23.
//  Copyright © 2019 游宗諭. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  var timer = Timer()

  var pomodoro = Pomodoro()

  let mainView = MainView()

  override func loadView() {

    view = mainView
    mainView.delegate = self
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    mainView.setup()
    mainView.pickerSelect([15,5,3])
    //    mainView.picker.setValue(UIColor.red, forKey: "backgroundColor")
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    mainView.picker.subviews[1...2].indices.forEach{
      mainView.picker.subviews[$0].isHidden = true
    }

  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    NotificationCenter.default.addObserver(self,
                                           selector: #selector(appWillEnterForeground),
                                           name: UIApplication.willEnterForegroundNotification,
                                           object: nil)




  }
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  @objc func appWillEnterForeground() {
    mainView.setup()
  }
}

extension ViewController{
  func handler(for command:Command?){
    guard let command = command else {return}

    var time =  1.0
    #if DEBUG
    time = 0.1
    #endif

    switch command {
    case .start:
      print("start")
      mainView.picker.changeInteract()
      pomodoro.status = .working
      pomodoro.workTime_s = mainView.selectedtime.w * 60
      pomodoro.restTime_s = mainView.selectedtime.r * 60
      pomodoro.cycle = mainView.selectedtime.c
      timer = Timer.scheduledTimer(timeInterval: time, target: self, selector: #selector(self.updateStatus), userInfo: nil, repeats: true)
      break

    case .pause: timer.invalidate()
    case .resume: timer = Timer.scheduledTimer(timeInterval: time, target: self, selector: #selector(updateStatus), userInfo: nil, repeats: true)

    case .reset:
      print("reset")
      timer.invalidate()
      mainView.picker.isUserInteractionEnabled = true
      DispatchQueue.main.async {
        self.mainView.resetUI(to: self.pomodoro)
      }
      break
    case .setting:
      UIApplication
        .shared
        .open(URL(string: UIApplication.openSettingsURLString)!)
      break
    }
  }

  @objc func updateStatus(){

    pomodoro.remaidTime_s -= 1
    let second = pomodoro.remaidTime_s
    switch second >= 0{
    case true:
      update(second: second)
    case false:
      endTime()
      if pomodoro.isAutoResume {pomodoro.nextRound()}
    }


  }

  func endTime(){
    let message = pomodoro.remaidCycle > 0 ? "Finish, cycle remain: \(pomodoro.remaidCycle)" : "Finish"
    let badge = UIApplication.shared.applicationIconBadgeNumber
    UNCenter.sentNews(for: message,badge:badge)
    switch pomodoro.remaidCycle > 0{
    case true:
      pomodoro.nextRound()
      mainView.pickerSelect([pomodoro.workTime_s,pomodoro.restTime_s,pomodoro.remaidCycle])
    case false:
      timer.invalidate()
    }
  }



  func update(second:Int){


    switch pomodoro.status {
    case .working: mainView.updateLabel(w_time_s: pomodoro.remaidTime_s,
                                        r_time_s: pomodoro.restTime_s,
                                        cycle: pomodoro.remaidCycle)
    mainView.picker.selectRow(second / 60, inComponent: 0, animated: true)
    case .resting: mainView.updateLabel(w_time_s: pomodoro.workTime_s,
                                        r_time_s: pomodoro.remaidTime_s,
                                        cycle: pomodoro.remaidCycle)
    mainView.picker.selectRow(second / 60, inComponent: 1, animated: true)
    }
  }


}


enum Command{
  case start
  case reset
  case pause
  case resume
  case setting

  init?(for message:String){
    switch  message {
    case Theme.commandName[0]:
      self = .start
    case Theme.commandName[1]:
      self = .reset
    case Theme.commandName[2]:
      self = .setting
    case Theme.commandName[3]:
      self = .pause
    case Theme.commandName[6]:
      self = .resume


    default:
      return nil
    }

  }
}


