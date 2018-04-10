import XCTest
@testable import Notes

class NotesListViewControllerTests: XCTestCase {
    
    var notesListViewController : NotesListViewController?
    
    override func setUp() {
        super.setUp()
        notesListViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotesListViewControllerIdentifier") as? NotesListViewController
    }
    
    override func tearDown() {
        notesListViewController = nil
        super.tearDown()
    }
    
    func testIBOutlets() {
        let _ = notesListViewController?.view // force loading subviews and setting outlets
        
        XCTAssertNotNil(notesListViewController?.mainTableView)
        XCTAssertNotNil(notesListViewController?.addNoteButton)
    }
    
}
