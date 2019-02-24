//
//  ViewController.swift
//  Minimalism Pomodoro
//
//  Created by 游宗諭 on 2019/2/23.
//  Copyright © 2019 游宗諭. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  let mainView = MainView()

  override func loadView() {

    view = mainView
    mainView.delegate = self
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    mainView.setup()
  }
}





