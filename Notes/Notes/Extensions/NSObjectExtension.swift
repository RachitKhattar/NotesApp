import Foundation

extension NSObject {
    class func className() -> String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    func className() -> String {
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
    }
}
