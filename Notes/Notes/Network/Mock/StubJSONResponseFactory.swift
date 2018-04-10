import Foundation

enum StubJSONResponseFactory {
    case fetchNotesSuccess
    
    func jsonDict() -> [String: Any] {
        switch self {
        case .fetchNotesSuccess:
            return [
                "code": 200,
                "body": [
                    "notes": [
                        "0": [
                            "title": "Cache",
                            "text": "All notes are stored in the User Defaults after the fetch",
                            "id": "8474EAEC-3699-4B53-91C8-82BDDCF8482C"
                        ],
                        "1": [
                            "title": "Network Fetch",
                            "text": "Notes are fetched only for the 1st time the app is launched. This too is a STUBBED request and the delay added is just for display purposes",
                            "id": "D613F0DD-7A11-4EB7-8A17-A8A8BA06F954"
                        ],
                        "2": [
                            "title": "Notes App Intro",
                            "text": "This is a basic Note Taking application",
                            "id": "02D4B44F-B2A6-4065-8E0D-495006278693"
                        ],
                        "3": [
                            "title": "Add Note",
                            "text": "After a note is created, it is added to the top of the list and stored locally in the User Defaults",
                            "id": "9B1D5900-8605-4549-8E55-07B17895BF7C"
                        ],
                        
                    ]
                ]
            ]
        }
    }
}
