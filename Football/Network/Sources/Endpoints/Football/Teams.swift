
public extension Football {
    
    /// This enum defines the currently supported API routes.
    enum Teams: APIRoute {
        case allTeams(page: Int)
        case teamByID(_ id: Int)
        case teamByCountryID(_ countryID: Int)
        case teamBySeasonID(_ seasonID: Int)
        case teamSearch(query: String)
    }
}

public extension Football.Teams {
    
    var path: String {
        switch self {
        case .allTeams:
            return "/teams"
        case .teamByID(let id):
            return "/teams/\(id)"
        case .teamByCountryID(let countryID):
            return "/teams/countries/\(countryID)"
        case .teamBySeasonID(let seasonID):
            return "/teams/seasons/\(seasonID)"
        case .teamSearch(let query):
            return "/teams/search/\(query)"
        }
    }
    
    var queryParams: [String: String]? {
        switch self {
        case .allTeams(let page):
            return ["page": "\(page)", "include": "players; coaches"]
        case .teamByID(let id):
            return nil
        case .teamByCountryID(let countryID):
            return nil
        case .teamBySeasonID(let seasonID):
            return nil
        case .teamSearch(let query):
            return nil
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .allTeams, .teamByID, .teamByCountryID, .teamBySeasonID, .teamSearch:
            return .get
        }
    }
    
    var mockFile: String? {
        switch self {
        case .allTeams:
            return "_mockTeamsResponse"
        default: return ""
        }
    }
}
