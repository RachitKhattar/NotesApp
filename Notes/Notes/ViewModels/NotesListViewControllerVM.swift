import Foundation

enum NotesListRowType: Int {
    case note
    case fetchingNotes
}

enum NotesListRowDetail {
    case note(NoteTableCellVM)
    case fetchingNotes
}

protocol NotesListViewControllerVMDelegate: class {
    func dataUpdated()
}

class NotesListViewControllerVM {
    var notes: [Note] = [Note]()
    var rows: [NotesListRowType] = [NotesListRowType]()
    weak var delegate: NotesListViewControllerVMDelegate?
    
    func viewLoaded() {
        if CommonStorage.fetchedNotesOnce {
            fetchFromStorageAndReload()
        } else {
            rows.append(.fetchingNotes)
            
            Utility.delay(2.0) { [weak self] in
                self?.fetchNotes()
            }
        }
    }
    
    private func fetchNotes() {
        StubFactory.createFetchNotesSuccessStub()
        NotesClient.fetchNotes(with: "testIdentifier", failure: { (errorCode) in
            // show Error
        }) { [weak self] (response) in
            guard let response = response as? [String: Any],
            let body = response["body"] as? [String: Any],
            let notesFetched = body["notes"] as? [String: [String: Any]] else {
                    return
            }
            if let contains = self?.rows.contains(.fetchingNotes), contains {
                self?.rows.removeFirst()
                CommonStorage.fetchedNotesOnce = true
            }
            self?.fillUpNotes(with: notesFetched)
        }
    }
    
    private func fillUpNotes(with fetchedNotesDict: [String: [String: Any]]) {
        var dictsToStore: [[String: Any]] = [[String: Any]]()
        for key in fetchedNotesDict.keys {
            if let noteDict = fetchedNotesDict[key] {
                dictsToStore.append(noteDict)
            }
        }
        sendFetchedNotesToStorage(dictsToStore)
        fetchFromStorageAndReload()
    }
    
    private func fetchFromStorageAndReload() {
        notes = [Note]()
        rows = [NotesListRowType]()
        let storedNoteDicts = CommonStorage.storedNotes
        for dict in storedNoteDicts {
            if let note = Note.init(with: dict) {
                notes.append(note)
                rows.append(.note)
            }
        }
        delegate?.dataUpdated()
    }
    
    private func sendFetchedNotesToStorage(_ fetchedDicts: [[String: Any]]) {
        CommonStorage.storedNotes = fetchedDicts
    }
    
    func saveNote(_ note: Note) {
        addNoteToStorage(note)
        fetchFromStorageAndReload()
    }
    
    private func addNoteToStorage(_ note: Note) {
        var storedNoteDicts = CommonStorage.storedNotes
        let noteDict = note.toDict()
        storedNoteDicts.insert(noteDict, at: 0)
        CommonStorage.storedNotes = storedNoteDicts
    }
    
    func getNumberOfRows() -> Int {
        return rows.count
    }
    
    func getCellDetails(for index: Int) -> NotesListRowDetail? {
        if index < rows.count && index >= 0 {
            switch rows[index] {
                case .note:
                    let noteCellVM = NoteTableCellVM(note: notes[index])
                    return .note(noteCellVM)
            case .fetchingNotes:
                return .fetchingNotes
            }
        }
        return nil
    }
}
