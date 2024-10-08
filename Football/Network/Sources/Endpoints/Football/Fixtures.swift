
extension Football {
    
    /// This enum defines the currently supported API routes.
    enum Fixtures: APIRoute {
        case allFixtures(page: Int)
        case fixtureByID(_ id: Int)
        case fixturesByMultipleIDs(_ ids: [Int], page: Int)
        case fixturesByDate(_ date: String, page: Int)
        case fixturesByDateRange(startDate: String, endDate: String, page: Int)
        case fixturesByDateRangeForTeam(startDate: String, endDate: String, teamID: Int, page: Int)
        case fixturesByHeadToHead(teamID1: Int, teamID2: Int, page: Int)
        case fixturesSearch(query: String, page: Int)
        case upcomingFixturesByMarketID(_ marketID: Int, page: Int)
        case upcomingFixturesByTVStationID(_ tvStationID: Int, page: Int)
        case pastFixturesByTVStationID(_ tvStationID: Int, page: Int)
        case fixturesByLastUpdatedFixtures(page: Int)
    }
}

extension Football.Fixtures {
    
    var path: String {
        switch self {
        case .allFixtures:
            return "/fixtures"
        case .fixtureByID(let id):
            return "/fixtures/\(id)"
        case .fixturesByMultipleIDs(let ids, _):
            return "/fixtures/multi/\(ids)"
        case .fixturesByDate(let date, _):
            return "/fixtures/date/\(date)"
        case .fixturesByDateRange(let startDate, let endDate, _):
            return "/fixtures/between/\(startDate)/\(endDate)"
        case .fixturesByDateRangeForTeam(let startDate, let endDate, let teamID, _):
            return "/fixtures/between/\(startDate)/\(endDate)/\(teamID)"
        case .fixturesByHeadToHead(let teamID1, let teamID2, _):
            return "/fixtures/head-to-head/\(teamID1)/\(teamID2)"
        case .fixturesSearch(let query, _):
            return "/fixtures/search/\(query)"
        case .upcomingFixturesByMarketID(let marketID, _):
            return "/fixtures/upcoming//markets/\(marketID)"
        case .upcomingFixturesByTVStationID(let tvStationID, _):
            return "/fixtures/upcoming//tv-stations/\(tvStationID)"
        case .pastFixturesByTVStationID(let tvStationID, _):
            return "/fixtures/past//tv-stations/\(tvStationID)"
        case .fixturesByLastUpdatedFixtures(_):
            return "/fixtures/latest"
        }
    }
    
    var queryParams: [String: String]? {
        switch self {
        case .allFixtures(let page):
            return ["page": "\(page)", "include": "participants"]
        case .fixtureByID:
            return ["include": "participants"]
        case .fixturesByMultipleIDs(_, let page):
            return ["page": "\(page)", "include": "participants"]
        case .fixturesByDate(_, let page):
            return ["page": "\(page)", "include": "participants"]
        case .fixturesByDateRange(_, _, let page):
            return ["page": "\(page)", "include": "participants"]
        case .fixturesByDateRangeForTeam(_, _, _, let page):
            return ["page": "\(page)", "include": "participants"]
        case .fixturesByHeadToHead(_, _, let page):
            return ["page": "\(page)", "include": "participants"]
        case .fixturesSearch(_, let page):
            return ["page": "\(page)", "include": "participants"]
        case .upcomingFixturesByMarketID(_, let page):
            return ["page": "\(page)", "include": "participants"]
        case .upcomingFixturesByTVStationID(_, let page):
            return ["page": "\(page)", "include": "participants"]
        case .pastFixturesByTVStationID(_, let page):
            return ["page": "\(page)", "include": "participants"]
        case .fixturesByLastUpdatedFixtures(let page):
            return ["page": "\(page)", "include": "participants"]
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .allFixtures, .fixtureByID, .fixturesByMultipleIDs, .fixturesByDate, .fixturesByDateRange, .fixturesByDateRangeForTeam, .fixturesByHeadToHead, .fixturesSearch, .upcomingFixturesByMarketID, .upcomingFixturesByTVStationID, .pastFixturesByTVStationID, .fixturesByLastUpdatedFixtures:
            return .get
        }
    }
    
    var mockFile: String? {
        switch self {
        case .allFixtures:
            return "_mockFixturesResponse"
        default: return ""
        }
    }
}
