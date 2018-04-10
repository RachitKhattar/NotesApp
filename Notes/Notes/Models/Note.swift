import Foundation

struct Note {
    var title   : String
    var text    : String
    var id      : String
    var time    : Date
    
    init(with header: String, body: String) {
        title = header
        text = body
        id = UUID().uuidString
        time = Date()
    }
    
    init?(with dictionary: [String: Any]) {
        guard   let titleFromDict = dictionary["title"] as? String,
                let textFromDict = dictionary["text"] as? String,
                let idFromDict = dictionary["id"] as? String else {
                return nil
        }
        title = titleFromDict
        text = textFromDict
        id = idFromDict
        time = Date()
    }
    
    func toDict() -> [String: Any] {
        var dict: [String: Any] = [String: Any]()
        dict["title"] = title
        dict["text"] = text
        dict["id"] = id
        return dict
    }
}
