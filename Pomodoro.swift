//
//  Pomodoro.swift
//  Minimalism Pomodoro
//
//  Created by 游宗諭 on 2019/2/24.
//  Copyright © 2019 游宗諭. All rights reserved.
//

import Foundation

struct Pomodoro {
  private init(){}
  let timer = Timer()
  let time = [15,00]

  func start() {
//    Timer.scheduledTimer(timeInterval: <#T##TimeInterval#>,
//                         target: <#T##Any#>,
//                         selector: <#T##Selector#>,
//                         userInfo: <#T##Any?#>,
//                         repeats: true)
  }

  static let shared = Pomodoro()

}
