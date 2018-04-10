import UIKit

enum ColorTheme: String {
    case primaryRed = "#DD4C4F"
    case textGray = "#A3ABB3"
    case titleBlack = "#222222"
    case appBackground = "#FBFBFB"
    case borderColor = "#DEDEDE"
    
    func color() -> UIColor {
        return UIColor.init(hex: self.rawValue) ?? UIColor.black
    }
}
