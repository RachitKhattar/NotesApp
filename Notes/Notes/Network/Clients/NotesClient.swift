import Foundation
import Alamofire

class NotesClient: BaseAPIClient {
    class func fetchNotes(with identifier: String, failure: @escaping (_ errorCode: Int?) -> Void, success: @escaping (_ response: Any?) -> Void) {
        sessionManager.request(APIRouter.fetchNotes(identfier: identifier)).responseJSON { response in
            switch response.response?.statusCode {
            case HTTPStatusCode.ok.rawValue?:
                success(response.result.value)
            default:
                failure(response.response?.statusCode)
            }
        }
    }
}
