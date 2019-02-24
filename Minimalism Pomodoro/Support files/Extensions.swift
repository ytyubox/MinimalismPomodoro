//
//  Extensions.swift
//  ConcetrationGame
//
//  Created by 游宗諭 on 2019/2/4.
//  Copyright © 2019 游宗諭. All rights reserved.
//

import Foundation
import UIKit.UIView
extension Collection{
  var oneAndOnly:Element?{
    return count == 1  ? first : nil
  }
}

extension Int{
  var arc4random:Int{
    let value:Int
    switch true {
    case self > 0:
      value = Int(arc4random_uniform(UInt32(self)))
    case self == 0:
      value = 0
    case self < 0:
      value = -Int(arc4random_uniform(UInt32(abs(self))))
    default:
      value = 0
    }
    return value
  }
}


extension UIView{

  func addSubviews( _ views: UIView...) {
    views.forEach{addSubview($0)}
  }

  func fillSuperView(padding : UIEdgeInsets = .zero){
    anchor(t: superview?.topAnchor,
           l: superview?.leadingAnchor,
           b: superview?.bottomAnchor,
           t: superview?.trailingAnchor,
           padding: padding
    )
  }


  func anchorSize(to view:UIView){
    heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    widthAnchor .constraint(equalTo: view.widthAnchor ).isActive = true
  }
  func anchorWH(width: CGFloat?, height:CGFloat?) {
    translatesAutoresizingMaskIntoConstraints = false
    if let width = width{
      widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    if let height = height{
      heightAnchor.constraint(equalToConstant: height).isActive = true
    }
  }

  func anchor(t top:NSLayoutYAxisAnchor? = nil,
              l leading:NSLayoutXAxisAnchor? = nil,
              b bottom:NSLayoutYAxisAnchor? = nil,
              t trailing:NSLayoutXAxisAnchor? = nil,
              padding : UIEdgeInsets = .zero,
              size:CGSize = .zero) {
    translatesAutoresizingMaskIntoConstraints = false
    if let top = top {
      topAnchor        .constraint(equalTo: top,           constant: padding.top)        .isActive = true}
    if let leading = leading{
      leadingAnchor    .constraint(equalTo: leading,    constant: padding.left)        .isActive = true}
    if let bottom = bottom{
      bottomAnchor    .constraint(equalTo: bottom,     constant: -padding.bottom)    .isActive = true}
    if let trailing = trailing{
      trailingAnchor    .constraint(equalTo: trailing,     constant: -padding.right)    .isActive = true}
    if size .width != 0 {
      widthAnchor.constraint(equalToConstant: size.width).isActive = true}
    if size.height != 0 {
      heightAnchor.constraint(equalToConstant: size.height).isActive = true}
  }

  func center(to view:UIView,
              dx:CGFloat = 0,
              dy:CGFloat = 0){
    translatesAutoresizingMaskIntoConstraints = false
    centerXAnchor.constraint(equalTo: view.centerXAnchor,constant: dx).isActive = true
    centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: dy).isActive = true
  }
}

extension Int{
  var squared:Int{return self * self}
}
