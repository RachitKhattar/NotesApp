import UIKit

class NoteTableCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = ColorTheme.titleBlack.color()
        }
    }
    @IBOutlet weak var bodyLabel: UILabel! {
        didSet {
            bodyLabel.textColor = ColorTheme.textGray.color()
        }
    }
    @IBOutlet weak var bottomLine: UIView! {
        didSet {
            bottomLine.backgroundColor = ColorTheme.borderColor.color().withAlphaComponent(0.6)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with vm: NoteTableCellVM) {
        titleLabel.text = vm.note.title
        bodyLabel.text = vm.note.text
    }
}
