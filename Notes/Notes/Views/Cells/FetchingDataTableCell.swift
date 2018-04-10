import UIKit

class FetchingDataTableCell: UITableViewCell {
    
    @IBOutlet weak var fetchLabel: UILabel! {
        didSet {
            fetchLabel.textColor = ColorTheme.textGray.color()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
