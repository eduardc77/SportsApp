
public extension Football {
    
    /// This enum defines the currently supported API routes.
    enum Coaches: APIRoute {
        case allCoaches(page: Int)
        case coachesByID(_ id: Int)
        case coachesByCountryID(_ countryID: Int)
        case coachesSearch(query: String)
        case lastUpdatedCoaches
    }
}

public extension Football.Coaches {
    
    var path: String {
        switch self {
        case .allCoaches:
            return "/coaches"
        case .coachesByID(let id):
            return "/coaches/\(id)"
        case .coachesByCountryID(let countryID):
            return "/coaches/countries/\(countryID)"
        case .coachesSearch(let query):
            return "/coaches/search/\(query)"
        case .lastUpdatedCoaches:
            return "/coaches/latest"
        }
    }
    
    var queryParams: [String: String]? {
        switch self {
        case .allCoaches(let page):
            return ["page": "\(page)"]
        case .coachesByID:
            return [:]
        case .coachesByCountryID:
            return nil
        case .coachesSearch:
            return nil
        case .lastUpdatedCoaches:
            return nil
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .allCoaches, .coachesByID, .coachesByCountryID, .coachesSearch, .lastUpdatedCoaches:
            return .get
        }
    }
    
    var mockFile: String? {
        switch self {
        case .allCoaches:
            return "_mockCoachesResponse"
        default: return ""
        }
    }
}
