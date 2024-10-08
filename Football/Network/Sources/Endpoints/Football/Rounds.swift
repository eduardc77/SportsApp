
extension Football {
    
    /// This enum defines the currently supported API routes.
    enum Rounds: APIRoute {
        case allRounds(page: Int)
        case roundByID(_ id: Int)
        case roundBySeasonID(_ id: Int)
        case roundsSearch(query: String, page: Int)
    }
}

extension Football.Rounds {
    
    var path: String {
        switch self {
        case .allRounds:
            return "/rounds"
        case .roundByID(let id):
            return "/rounds/\(id)"
        case .roundBySeasonID(let seasonID):
            return "/rounds/seasons/\(seasonID)"
        case .roundsSearch(let query, _):
            return "/rounds/search/\(query)"
        }
    }
    
    var queryParams: [String: String]? {
        switch self {
        case .allRounds(let page):
            return ["page": "\(page)", "include": "fixtures"]
        case .roundByID:
            return ["include": "fixtures"]
        case .roundBySeasonID:
            return ["include": "fixtures"]
        case .roundsSearch(_, let page):
            return ["page": "\(page)", "include": "fixtures"]
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .allRounds, .roundByID, .roundBySeasonID, .roundsSearch:
            return .get
        }
    }
    
    var mockFile: String? {
        switch self {
        case .allRounds:
            return "_mockRoundsResponse"
        default: return ""
        }
    }
}
