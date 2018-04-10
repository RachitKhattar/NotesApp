import UIKit

protocol AddNotesViewControllerDelegate: class {
    func save(_ note: Note)
}

class AddNotesViewController: UIViewController {
    weak var delegate: AddNotesViewControllerDelegate?
    @IBOutlet weak var titleTextField: UITextField! {
        didSet {
            titleTextField.textColor = ColorTheme.titleBlack.color()
            titleTextField.delegate = self
        }
    }
    @IBOutlet weak var bodyTextView: UITextView! {
        didSet {
            bodyTextView.textColor = ColorTheme.textGray.color()
            bodyTextView.delegate = self
            bodyTextView.text = "Enter note body here"
        }
    }
    @IBOutlet weak var saveButton: UIButton! {
        didSet {
            saveButton.setTitleColor(UIColor.white, for: .normal)
            saveButton.backgroundColor = ColorTheme.primaryRed.color()
        }
    }
    @IBOutlet weak var saveButtonBottomConstraint: NSLayoutConstraint!
    let titleMaxLimit: Int = 30
    let bodyMaxLimit: Int = 270
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications()
    }
    
    @IBAction
    func saveButtonTapped(_ sender: UIButton) {
        let title = titleTextField.text ?? ""
        let text = bodyTextView.text ?? ""
        let note = Note(with: title, body: text)
        delegate?.save(note)
        navigationController?.popViewController(animated: true)
    }
}

// MARK:- Keyboard Events
extension AddNotesViewController {
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue, let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval, let curve = notification.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? Int {
            self.saveButtonBottomConstraint.constant = 10 + keyboardSize.height
            UIView.animateKeyframes(withDuration: duration, delay: 0, options: UIViewKeyframeAnimationOptions(rawValue: UInt(curve)), animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        if let userInfo = notification.userInfo, let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? Int, let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval {
            self.saveButtonBottomConstraint.constant = 10
            UIView.animateKeyframes(withDuration: duration, delay: 0, options: UIViewKeyframeAnimationOptions(rawValue: UInt(curve)), animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
}

extension AddNotesViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var textFieldLength = 0
        if let text = textField.text {
            textFieldLength = text.count
        }
        let finalLength = textFieldLength - range.length + string.count
        return finalLength > titleMaxLimit ? false : true
    }
}

extension AddNotesViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        var textViewLength = 0
        if let textunwrapped = textView.text {
            textViewLength = textunwrapped.count
        }
        let finalLength = textViewLength - range.length + text.count
        return finalLength > bodyMaxLimit ? false : true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Enter note body here" {
            textView.text = nil
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter note body here"
        }
    }
}
