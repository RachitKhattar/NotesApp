import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) {
        self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier())
    }
    
    func registerNib<T: UITableViewCell>(_: T.Type) {
        let nib = T.nib()
        self.register(nib, forCellReuseIdentifier: T.reuseIdentifier())
    }
    
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier(), for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier())")
        }
        
        return cell
    }
}
