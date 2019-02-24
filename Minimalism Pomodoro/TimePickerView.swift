//
//  TimePickerView.swift
//  Minimalism Pomodoro
//
//  Created by 游宗諭 on 2019/2/24.
//  Copyright © 2019 游宗諭. All rights reserved.
//

import UIKit.UIPickerView


class TimePickerView:UIPickerView{

  var title_Picker:[[Int]] = [
    Array((0...60)),
    Array((0...59))
  ]
}



extension TimePickerView:UIPickerViewDataSource{
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return title_Picker.count
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return title_Picker[component].count
  }
}
let width = 20

extension TimePickerView:UIPickerViewDelegate{
  func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    let view = UIView(frame: .init(x: 0, y: 0, width: width, height: 50))
    let numberlabel = UILabel(frame: .init(x: -width / 2, y: 0, width: width * 2, height: 20))
    numberlabel.font = UIFont.boldSystemFont(ofSize: 20)
    numberlabel.text = row % 5 == 0 ? String(title_Picker[component][row]) : ""


    let barLabel = UILabel(frame: .init(x: 0, y: 20, width: width, height: 30))
    barLabel.text = (row % 5 == 0) ? "|" : "ı"


    [numberlabel,barLabel]
      .forEach{
        $0.textAlignment = .center
        $0.textColor = Theme.foregroundColor
    }
    view.addSubviews(numberlabel,barLabel)
//    view.backgroundColor = Theme.backgroundColor
    var transform = CGAffineTransform.identity
    transform = transform.rotated(by: .pi / 2)
    transform = transform.scaledBy(x: 1, y: -1)
    view.transform = transform
    return view
  }
  func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
    return CGFloat(width)
  }

  func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
    return 50
  }

  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

    guard let superview = superview as? MainView else {return}
    switch component {
    case 0:
      superview.selectedtime.w = title_Picker[component][row]
    case 1:
      superview.selectedtime.r = title_Picker[component][row]
    default:
      break
    }
  }

}
