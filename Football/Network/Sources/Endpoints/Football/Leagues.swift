
public extension Football {
    
    /// This enum defines the currently supported API routes.
    enum Leagues: APIRoute {
        case allLeagues(page: Int)
        case leagueByID(_ id: Int)
        case leagueLive
        case leagueByFixtureDate(date: String)
        case leagueByCountryID(_ countryID: Int)
        case leaguesSearch(query: String)
    }
    
}

public extension Football.Leagues {
    
    var path: String {
        switch self {
        case .allLeagues:
            return "/leagues"
        case .leagueByID(let id):
            return "/leagues/\(id)"
        case .leagueLive:
            return "/leagues/live"
        case .leagueByFixtureDate(let date):
            return "/leagues/date/\(date)"
        case .leagueByCountryID(let countryID):
            return "/leagues/countries/\(countryID)"
        case .leaguesSearch(let query):
            return "/leagues/search/\(query)"
        }
    }
    
    var queryParams: [String: String]? {
        switch self {
        case .allLeagues(let page):
            return ["page": "\(page)", "include": "seasons; currentSeason"]
        case .leagueByID:
            return nil
        case .leagueLive:
            return nil
        case .leagueByFixtureDate:
            return nil
        case .leagueByCountryID:
            return nil
        case .leaguesSearch:
            return nil
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .allLeagues, .leagueByID, .leagueLive, .leagueByFixtureDate, .leagueByCountryID, .leaguesSearch:
            return .get
        }
    }
    
    var mockFile: String? {
        switch self {
        case .allLeagues:
            return "_mockLeaguesResponse"
        default: return ""
        }
    }
}
