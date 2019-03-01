//
//  VerticalAlignedLabel.swift
//  Minimalism Pomodoro
//
//  Created by 游宗諭 on 2019/2/27.
//  Copyright © 2019 游宗諭. All rights reserved.
//

import UIKit.UILabel
class VerticalAlignedLabel: UILabel {

  override func drawText(in rect: CGRect) {
    var newRect = rect
    switch contentMode {
    case .top:
      newRect.size.height = sizeThatFits(rect.size).height
    case .bottom:
      let height = sizeThatFits(rect.size).height
      newRect.origin.y += rect.size.height - height
      newRect.size.height = height
    default:
      ()
    }

    super.drawText(in: newRect)
  }
}
