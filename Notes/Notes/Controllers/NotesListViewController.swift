import UIKit

class NotesListViewController: UIViewController {
    var viewModel: NotesListViewControllerVM!
    @IBOutlet weak var mainTableView: UITableView! {
        didSet {
            mainTableView.delegate = self
            mainTableView.dataSource = self
            mainTableView.registerNib(NoteTableCell.self)
            mainTableView.register(UITableViewCell.self)
            mainTableView.registerNib(FetchingDataTableCell.self)
            mainTableView.estimatedRowHeight = 20
        }
    }
    
    @IBOutlet weak var addNoteButton: UIButton! {
        didSet {
            addNoteButton.setTitleColor(UIColor.white, for: .normal)
            addNoteButton.backgroundColor = ColorTheme.primaryRed.color()
            addNoteButton.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = NotesListViewControllerVM()
        viewModel.delegate = self
        viewModel.viewLoaded()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddNote" {
            if let destController = segue.destination as? AddNotesViewController {
                destController.delegate = self
            }
        }
    }
}

extension NotesListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cellType = viewModel.getCellDetails(for: indexPath.row) {
            switch cellType {
            case .note(let vm):
                let customCell: NoteTableCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                customCell.configure(with: vm)
                return customCell
            case .fetchingNotes:
                let customCell: FetchingDataTableCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                return customCell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension NotesListViewController: NotesListViewControllerVMDelegate {
    func dataUpdated() {
        print("data Updated")
        addNoteButton.isHidden = false
        mainTableView.reloadData()
    }
}

extension NotesListViewController: AddNotesViewControllerDelegate {
    func save(_ note: Note) {
        viewModel.saveNote(note)
    }
}

