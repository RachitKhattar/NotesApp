import Foundation
import Alamofire

enum HTTPStatusCode: Int {
    case ok = 200
    case created
    case accepted
    case noContent = 204
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case unprocessibleEntity = 422
    case conflict = 409
    case internalError = 500
    case networkError = -1
    case unknownError = 1000
}

class BaseAPIClient: NSObject {
    static let sessionManager: SessionManager = SessionManager.default
}
