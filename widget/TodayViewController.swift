//
//  TodayViewController.swift
//  widget
//
//  Created by 游宗諭 on 2019/2/27.
//  Copyright © 2019 游宗諭. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {


//  let  picker = TimePickerView()


    override func viewDidLoad() {
        super.viewDidLoad()

//      view.addSubview(picker)
//      picker.fillSuperView()
      
        // Do any additional setup after loading the view from its nib.
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
