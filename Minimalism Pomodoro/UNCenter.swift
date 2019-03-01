//
//  UNCenter.swift
//  Minimalism Pomodoro
//
//  Created by 游宗諭 on 2019/2/25.
//  Copyright © 2019 游宗諭. All rights reserved.
//
import UIKit.UIApplication
import UserNotifications

class UNCenter{

  private init (){}

  class func defaultAuthrtzation(){
//    UNUserNotificationCenter.current().requestAuthorization(options: [<#T##UNAuthorizationOptions#>], completionHandler: <#T##(Bool, Error?) -> Void#>)
  }

  class func requestAuthorization(){
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { (granted, error) in

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
    }

  }

  static var theBadge = 0

  class func sentNews(for news:String,badge:Int){
    theBadge = badge
    sendNotification(title: news, subTitle: "", body: "")
  }

  class func sendNotification(title:String,
                              subTitle:String,
                              body:String,
                              badge:Int? = nil,
                              delayTimeInterval:TimeInterval? = nil) {

    let notificationContent = UNMutableNotificationContent()
    notificationContent.title = title
    notificationContent.subtitle = subTitle
    notificationContent.body = body


    let delayTimerTrigger = (delayTimeInterval == nil) ? nil :
      UNTimeIntervalNotificationTrigger(timeInterval: delayTimeInterval!, repeats: false)

    let currentBadgeCount = theBadge + (badge ?? 0)

    notificationContent.badge = NSNumber(integerLiteral: currentBadgeCount)

    notificationContent.sound = UNNotificationSound.default

    let request = UNNotificationRequest(identifier: "Porodoro", content: notificationContent, trigger: delayTimerTrigger)
    UNUserNotificationCenter.current().add(request) { (error) in
      if let error = error{
        print(error.localizedDescription)
      }
    }


  }

}
