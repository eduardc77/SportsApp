
public extension Football {
    
    /// This enum defines the currently supported API routes.
    enum Squads: APIRoute {
        
        case squadsByTeamID(_ id: Int, page: Int)
        case extendedSquadByTeamID(_ id: Int, page: Int)
        case squadsBySeasonID(_ seasonID: Int, teamID: Int, page: Int)
    }
}

public extension Football.Squads {
    
    var path: String {
        switch self {
        case .squadsByTeamID(let id, _):
            return "/squads/teams/\(id)"
        case .extendedSquadByTeamID(let id, _):
            return "/squads/teams/\(id)/extended"
        case .squadsBySeasonID(let seasonID, let teamID, let page):
            return "/squads/seasons/\(seasonID)/teams/\(teamID)"
        }
    }
    
    var queryParams: [String: String]? {
        switch self {
        case .squadsByTeamID(let id, let page):
            return ["page": "\(page)"]
        case .extendedSquadByTeamID(let id, let page):
            return ["page": "\(page)"]
        case .squadsBySeasonID(let seasonID, let teamID, let page):
            return ["page": "\(page)"]
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .squadsByTeamID, .extendedSquadByTeamID, .squadsBySeasonID:
            return .get
        }
    }
    
    var mockFile: String? {
        switch self {
        case .squadsByTeamID:
            return "_mockTeamsResponse"
        default: return ""
        }
    }
}
