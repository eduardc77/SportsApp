
import Foundation

public struct MockApiRoute: Decodable, APIRoute {
    public let httpMethod: HTTPMethod
    public let path: String
    public let formParams: [String : String]?
    public let postData: Data?
    public let queryItems: [URLQueryItem]?
 
    public let mockFile: String?
    
    public init(httpMethod: HTTPMethod = .get, path: String = "/test", formParams: [String : String]? = nil, postData: Data? = nil, queryItems: [URLQueryItem]? = nil, mockFile: String? = nil) {
        self.httpMethod = httpMethod
        self.path = path
        self.formParams = formParams
        self.postData = postData
        self.queryItems = queryItems
        self.mockFile = mockFile
    }
    
    public init(from decoder: any Decoder) throws {
        self.httpMethod = .get
        self.path = "/test"
        self.formParams = nil
        self.postData = nil
        self.queryItems = nil
        self.mockFile = nil
    }
}
