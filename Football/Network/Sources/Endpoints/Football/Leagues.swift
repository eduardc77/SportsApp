
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
            return ["page": "\(page)"]
        case .leagueByID(let id):
            return nil
        case .leagueLive:
            return nil
        case .leagueByFixtureDate(let date):
            return nil
        case .leagueByCountryID(let countryID):
            return nil
        case .leaguesSearch(let query):
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
