
extension Football {

    /// This enum defines the currently supported API routes.
    enum Players: APIRoute {
        case allPlayers(page: Int)
        case playerByID(_ id: Int)
        case playersByCountryID(_ countryID: Int)
        case playersSearch(query: String)
        case lastUpdatedPlayers
    }
}

extension Football.Players {
    
    var path: String {
        switch self {
        case .allPlayers:
            return "/players"
        case .playerByID(let id):
            return "/players/\(id)"
        case .playersByCountryID(let countryID):
            return "/players/countries/\(countryID)"
        case .playersSearch(let query):
            return "/players/search/\(query)"
        case .lastUpdatedPlayers:
            return "/players/latest"
        }
    }
    
    var queryParams: [String: String]? {
        switch self {
        case .allPlayers(let page):
            return ["page": "\(page)"]
        case .playerByID:
            return [:]
        case .playersByCountryID:
            return nil
        case .playersSearch:
            return nil
        case .lastUpdatedPlayers:
            return nil
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .allPlayers, .playerByID, .playersByCountryID, .playersSearch, .lastUpdatedPlayers:
            return .get
        }
    }
    
    var mockFile: String? {
        switch self {
        case .allPlayers:
            return "_mockPlayersResponse"
        default: return ""
        }
    }
}
