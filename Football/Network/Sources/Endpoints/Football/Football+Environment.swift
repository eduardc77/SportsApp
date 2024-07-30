
public extension Football {

    enum Environment: APIEnvironment {

        case production
        case preproduction
        case develop(apiToken: String)
    }
}

public extension Football.Environment {
    
    var baseURL: String {
        switch self {
        case .production: return ""
        case .preproduction: return ""
        case .develop: return "api.sportmonks.com"
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .production: return nil
        case .preproduction: return nil
        case .develop(let apiToken):
            return [
                "Authorization": "\(apiToken)"
            ]
        }
    }
    
    var apiVersion: String { "/v3/football" }
}
