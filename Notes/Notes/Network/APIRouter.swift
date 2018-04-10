import Foundation
import Alamofire

enum APIEndpoints: String {
    case fetchNotes     = "notes/fetch/"
}

enum APIRouter: URLRequestConvertible {
    static let baseURL = "http://192.168.29.206/"
    
    case fetchNotes(identfier: String)
    
    func asURLRequest() throws -> URLRequest {
        let details: (path: String, parameters: [String: Any]?, httpMethod: HTTPMethod) = {
            // create params for APIs
            var params: [String: Any] = [String: Any]()
            switch self {
                
            case .fetchNotes(let identifier):
                params["identifier"] = identifier
                return (APIEndpoints.fetchNotes.rawValue, params, HTTPMethod.get)
            }
        }()
        
        // create request
        var url = URL(string: APIRouter.baseURL)
        url = url?.appendingPathComponent(details.path)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = details.httpMethod.rawValue
        let encoding = JSONEncoding.default
        return try encoding.encode(urlRequest, with: details.parameters)
    }
}
