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
    Array((0...30)),
    Array((0...5)),
    Array((0...5))
  ]
  lazy var indicatorlabels:[UILabel] = (4...5).map {
    let label = UILabel()
    label.tag = $0
    label.text = Theme.commandName[$0]
    label.textAlignment = .center
    label.font = UIFont.boldSystemFont(ofSize: 50)
    addSubview(label)

    return label
  }
  let width = 20

  func setupTheme() {
    backgroundColor = Theme.backgroundColor

  }

  func changeInteract() {
    isUserInteractionEnabled.toggle()
  }
}



//MARK:- 
extension TimePickerView:UIPickerViewDataSource{
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return title_Picker.count
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return title_Picker[component].count
  }

}

//MARK:-
extension TimePickerView:UIPickerViewDelegate{
  func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    let view = UIView(frame: .init(x: 0, y: 0, width: width, height: 50))
    let numberlabel = VerticalAlignedLabel(frame: .init(x: -width / 2, y: 0, width: width * 2, height: 20))
    numberlabel.contentMode = .bottom
//    numberlabel.font = UIFont.boldSystemFont(ofSize: 20)
    let title =  String(title_Picker[component][row])
    let text = (component == 0) ?
      row % 5 == 0 ? title : "\(title.last!)" : title
    let size:CGFloat = (component == 0) ?
      row % 5 == 0 ? 20 : 15  : 18

    numberlabel.attributedText = NSAttributedString(string: text, attributes: [
      .font:UIFont.systemFont(ofSize: size)
      ])

//    if  {numberlabel.text = String(title_Picker[component][row])}


    let barLabel = VerticalAlignedLabel(frame: .init(x: 0, y: 20, width: width, height: 30))
    barLabel.text = (row % 5 == 0) ? "|" : "ı"



    [numberlabel,barLabel]
      .forEach{
        $0.textAlignment = .center
        $0.textColor = Theme.foregroundColor
    }
    view.addSubviews(numberlabel,barLabel)
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
      var row = row
      #if !DEBUG
      if row < 5{
        selectRow(5, inComponent: 0, animated: true)
        row = 5
      }
      #endif
      superview.selectedtime.w = title_Picker[component][row]
//      title_Picker[1] = (0...row).map{$0}


      if selectedRow(inComponent: 1) > row{
        selectRow(row, inComponent: 1, animated: true)
        superview.selectedtime.r = title_Picker[1].last ?? 0
      }
      reloadComponent(1)
    case 1:
      superview.selectedtime.r = title_Picker[component][row]
      if selectedRow(inComponent: 1) > selectedRow(inComponent: 0){
        selectRow(selectedRow(inComponent: 0), inComponent: 1, animated: true)
      }
    case 2:
      var row = row
      if row  == 0{
        selectRow(1, inComponent: 2, animated: true)
        row = 1
      }
    default:
      break
    }
     superview.selectedtime = (selectedRow(inComponent: 0),selectedRow(inComponent: 1),selectedRow(inComponent: 2))
  }

}
