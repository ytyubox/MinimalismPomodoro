//
//  Theme.swift
//  Minimalism Pomodoro
//
//  Created by 游宗諭 on 2019/2/24.
//  Copyright © 2019 游宗諭. All rights reserved.
//

import UIKit.UIColor

struct Theme {

  static var isNightMode:Bool {
    return UserDefaults.standard.bool(forKey: "isNightMode")
  }
  static var backgroundColor:UIColor {
    return isNightMode ? .black : .white
  }
  static var foregroundColor:UIColor{
    return isNightMode ? .white : .black
  }

  static let commandName = ["start","reset","setting"]

  private init(){
  }

}
