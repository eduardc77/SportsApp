
import Foundation
import Combine
@testable import Network

class TestClient: APIClient {
    
    init(
        data: Data = .init(),
        response: HTTPURLResponse = TestResponse.withStatusCode(200),
        error: Error? = nil
    ) {
        self.data = data
        self.response = response
        self.error = error
    }
    
    let data: Data
    let response: HTTPURLResponse
    let error: Error?
    
    /**
     This type can be returned by an ``ApiClient`` when a client
     requests data from an external API.
     */
    struct APIResult {
        
        init(
            data: Data,
            response: URLResponse
        ) {
            self.data = data
            self.response = response
        }
        
        var data: Data
        var response: URLResponse
    }
    
}

class TestResponse: HTTPURLResponse {
    
    var testStatusCode = 200
    
    override var statusCode: Int { testStatusCode }
    
    static func withStatusCode(
        _ code: Int
    ) -> TestResponse {
        let response = TestResponse(
            url: URL(string: "kankoda.com")!,
            mimeType: nil,
            expectedContentLength: 0,
            textEncodingName: nil
        )
        response.testStatusCode = code
        return response
    }
}

enum TestEnvironment: APIEnvironment {
    
    case staging
    case production
    
    var baseURL: String {
        switch self {
        case .staging: return "staging-api.imdb.com"
        case .production: return "api.imdb.com"
        }
    }
    
    var headers: [String: String]? {
        ["api-secret": "APISECRET"]
    }
    
    var queryParams: [String: String]? {
        ["api-key": "APIKEY"]
    }
}

enum TestRoute: APIRoute {
    
    case formLogin(userName: String, password: String)
    case movie(id: String)
    case postLogin(userName: String, password: String)
    case search(query: String, page: Int)
    case searchWithArrayParams(years: [Int])
    
    var httpMethod: HTTPMethod {
        switch self {
        case .formLogin: return .post
        case .movie: return .get
        case .postLogin: return .post
        case .search: return .get
        case .searchWithArrayParams: return .get
        }
    }
    
    var path: String {
        switch self {
        case .formLogin: return "/formLogin"
        case .movie(let id): return "/movie/\(id)"
        case .postLogin: return "/postLogin"
        case .search: return "/search"
        case .searchWithArrayParams: return "/search"
        }
    }
    
    var headers: [String: String]? {
        ["locale": "sv-SE"]
    }
    
    var formParams: [String: String]? {
        switch self {
        case .formLogin(let userName, let password):
            return ["username": userName, "password": password]
        default: return nil
        }
    }
    
    var uploadData: Data? {
        switch self {
        case .formLogin: return nil
        case .movie: return nil
        case .postLogin(let userName, let password):
            let request = TestLoginRequest(
                userName: userName, password: password
            )
            let encoder = JSONEncoder()
            return try? encoder.encode(request)
        case .search: return nil
        case .searchWithArrayParams: return nil
        }
    }
    
    var queryParams: [String: String]? {
        switch self {
        case .search(let query, let page): return [
            "q": query,
            "p": "\(page)"
        ]
        case .searchWithArrayParams(let years): return [
            "years": "[\(years.map { "\($0)"}.joined(separator: ","))]"
        ]
        default: return nil
        }
    }
    
    var mockFile: String? { "" }
}

struct TestLoginRequest: Codable {
    
    var userName: String
    var password: String
}

enum TestError: Error, Equatable {
    
    case baboooom
}

struct TestMovie: Codable {
    
    var id: String
    var name: String
}

struct TestPerson: Codable {
    
    var id: String
    var firstName: String
    var lastName: String
}
