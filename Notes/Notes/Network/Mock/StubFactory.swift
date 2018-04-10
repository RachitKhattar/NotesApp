import Foundation
import OHHTTPStubs

class StubFactory {
    
    @discardableResult
    class func createFetchNotesSuccessStub() -> OHHTTPStubsDescriptor {
        let jsonResponse = StubJSONResponseFactory.fetchNotesSuccess.jsonDict()
        return stub(condition: isPath("/notes/fetch"), response: { (_) -> OHHTTPStubsResponse in
            return OHHTTPStubsResponse(jsonObject: jsonResponse, statusCode: Int32(HTTPStatusCode.ok.rawValue), headers: .none)
        })
    }
    
}
