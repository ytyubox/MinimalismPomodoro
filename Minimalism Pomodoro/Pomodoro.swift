//
//  Pomodoro.swift
//  Minimalism Pomodoro
//
//  Created by 游宗諭 on 2019/2/24.
//  Copyright © 2019 游宗諭. All rights reserved.
//

import Foundation

class Pomodoro {

  var timer = Timer()

  var isAutoResume:Bool {
    return UserDefaults.standard.bool(forKey: "isAutoResume")
  }

  func nextRound() {
    guard remaidCycle > 0 else {return}
    status.change()
    switch status {
    case .resting:
      remaidTime_s = restTime_s
      remaidCycle -= 1
    case .working:
      remaidTime_s = workTime_s
    }

  }

  enum Status{
    case working
    case resting

    mutating func change() {
      switch self {
      case .working: self = .resting
      case .resting: self = .working
      }
    }
  }

  var status = Status.working

  var isRunning = false

  var isfinish :Bool {
    return isRunning
  }


  var workTime_s = 15 * 60 {
    didSet {
      remaidTime_s = isRunning ? remaidTime_s : workTime_s
  }}

  var restTime_s = 3 * 60
  var remaidCycle = 3
  var cycle = 3 {
    didSet{
      remaidCycle = cycle
    }
  }

  var remaidTime_s :Int =  15 * 60

  func start(handler:(()->Void)) {
    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(repeatMethod), userInfo: nil, repeats: true)

  }

  static let shared = Pomodoro()

}

extension Pomodoro{

  @objc func repeatMethod(handler:(()->Void)){
    guard remaidTime_s > 0 else {timer.invalidate();return}
  }
}
