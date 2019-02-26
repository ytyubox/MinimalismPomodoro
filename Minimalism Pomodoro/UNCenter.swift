//
//  UNCenter.swift
//  Minimalism Pomodoro
//
//  Created by 游宗諭 on 2019/2/25.
//  Copyright © 2019 游宗諭. All rights reserved.
//

import UserNotifications

class UNCenter{

  private init (){}


  class func requestAuthorization(){
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { (bool, error) in

      print(bool,error?.localizedDescription)

    }
  }
  class func sentUN(delay:TimeInterval,message:String){
    let content = UNMutableNotificationContent()
    content.title = message
    content.badge = 1
    content.sound = .default
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: delay, repeats: false)
    let request = UNNotificationRequest(identifier: "pomo1", content: content, trigger: trigger)

    UNUserNotificationCenter.current().add(request){ error in
      print("here======" , (error?.localizedDescription))
    }

  }

}
