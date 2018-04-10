import Foundation

struct StorageKey {
    static let kFetchedNotesOnce = "kFetchedNotesOnce"
    static let kStoredNotes = "kStoredNotes"
}

class CommonStorage {
    
    class var fetchedNotesOnce : Bool {
        get {
            return (retrieve(forKey: StorageKey.kFetchedNotesOnce) as? Bool ?? false)
        }
        set {
            store(newValue, forKey: StorageKey.kFetchedNotesOnce)
        }
    }
    
    class var storedNotes: [[String: Any]] {
        get {
            return (retrieve(forKey: StorageKey.kStoredNotes)) as? [[String: Any]] ?? [[String: Any]]()
        }
        set {
            store(newValue, forKey: StorageKey.kStoredNotes)
        }
    }
    
    static var userDefaults: UserDefaults {
        return UserDefaults.standard
    }
    
    class func store(_ object: Any, forKey key: String) {
        userDefaults.set(object, forKey: key)
        userDefaults.synchronize()
    }
    
    class func retrieve(forKey key: String) -> Any? {
        return userDefaults.object(forKey: key)
    }
    
    class func remove(forKey key: String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
}

