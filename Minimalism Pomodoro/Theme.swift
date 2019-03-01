import UIKit.UIColor

struct Theme {

  static var isNightMode:Bool {
    return UserDefaults.standard.bool(forKey: "isNightMode")
  }
  static var backgroundColor:UIColor {
    return isNightMode ? .black : .white
  }
  static var foregroundColor:UIColor{
    return isNightMode ? .white : .black
  }
  static var mediumColor:UIColor {
//    return isNightMode ? .darkGray : .lightGray
    return backgroundColor
  }

  static let commandName = ["start","reset","⚙︎","pause","▼","▲","Resume","?"]

  private init(){
  }

}
