//
//  TimePickerView.swift
//  Minimalism Pomodoro
//
//  Created by 游宗諭 on 2019/2/24.
//  Copyright © 2019 游宗諭. All rights reserved.
//

import UIKit.UIPickerView


class HoriPicker:UIPickerView{

  var title_Picker:[[String]] = [
    Array((0...60)).map{"\($0)"},
    ["3","4","5"]
  ]
  var didSelectedRowForComponent = [Int:String]()
}



extension HoriPicker:UIPickerViewDataSource{
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return title_Picker.count
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return title_Picker[component].count
  }
}

extension HoriPicker:UIPickerViewDelegate{
  func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    let width = 30
    let view = UIView(frame: .init(x: 0, y: 0, width: width, height: 50))
    let numberlabel = UILabel(frame: .init(x: 0, y: 0, width: width, height: 20))

    numberlabel.text = row % 5 == 0 ? String(title_Picker[component][row]) : ""


    let barLabel = UILabel(frame: .init(x: 0, y: 20, width: width, height: 30))
    barLabel.text = (row % 5 == 0) ? "|" : "ı"


    [numberlabel,barLabel].forEach{
      $0.textAlignment = .center
      }
    view.addSubviews(numberlabel,barLabel)
    view.backgroundColor = .yellow
    var transform = CGAffineTransform.identity
    transform = transform.rotated(by: .pi / 2)
    transform = transform.scaledBy(x: 1, y: -1)
    view.transform = transform
    return view
  }

//  func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
//    return 50
//  }
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    didSelectedRowForComponent[component] = title_Picker[component][row]
  }

//  func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
//    return 20
//  }
}
