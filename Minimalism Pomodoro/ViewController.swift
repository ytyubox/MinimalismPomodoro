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
    mainView.picker.selectRow(15, inComponent: 0, animated: true)
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    mainView.picker.subviews[1...2].indices.forEach{
    mainView.picker.subviews[$0].isHidden = true
    }
  }

}

extension ViewController{
  func handler(for :Command){

  }

}


enum Command{
  case start
  case reset
  case setting
}


