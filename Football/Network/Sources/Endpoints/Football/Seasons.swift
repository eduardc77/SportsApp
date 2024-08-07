
public extension Football {
    
    /// This enum defines the currently supported API routes.
    enum Seasons: APIRoute {
        case allSeasons(page: Int)
        case seasonByID(_ id: Int)
        case seasonsByTeamID(_ id: Int, page: Int)
        case seasonsSearch(query: String)
    }
}

public extension Football.Seasons {
    
    var path: String {
        switch self {
        case .allSeasons:
            return "/seasons"
        case .seasonByID(let id):
            return "/seasons/\(id)"
        case .seasonsByTeamID(let id, _):
            return "/seasons/teams/\(id)"
        case .seasonsSearch(let query):
            return "/seasons/search/\(query)"
        }
    }
    
    var queryParams: [String: String]? {
        switch self {
        case .allSeasons(let page):
            return ["page": "\(page)", "include": "stages; currentStage"]
        case .seasonByID:
            return nil
        case .seasonsByTeamID(_, let page):
            return ["page": "\(page)"]
        case .seasonsSearch:
            return nil
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .allSeasons, .seasonByID, .seasonsByTeamID, .seasonsSearch:
            return .get
        }
    }
    
    var mockFile: String? {
        switch self {
        case .allSeasons:
            return "_mockStagesResponse"
        default: return ""
        }
    }
}
