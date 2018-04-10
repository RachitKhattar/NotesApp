import UIKit

extension UIView {
    class func nib() -> UINib {
        return UINib(nibName: className(), bundle: nil)
    }
    
    class func reuseIdentifier() -> String {
        return "\(className())Identifier"
    }
}
