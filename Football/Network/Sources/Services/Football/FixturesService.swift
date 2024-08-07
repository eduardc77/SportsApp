
import Foundation

public protocol FixturesServiceable {
    
    func getAllFixtures<T: Decodable>(page: Int) async throws -> T
    func getFixtureByID<T: Decodable>(_ id: Int) async throws -> T
    func getFixturesByMultipleIDs<T: Decodable>(_ ids: [Int], page: Int) async throws -> T
    func getFixturesByDate<T: Decodable>(_ date: String, page: Int) async throws -> T
    func getFixturesByDateRange<T: Decodable>(startDate: String, endDate: String, page: Int) async throws -> T
    func getFixturesByDateRangeForTeam<T: Decodable>(startDate: String, endDate: String, teamID: Int, page: Int) async throws -> T
    func getFixturesByHeadToHead<T: Decodable>(teamID1: Int, teamID2: Int, page: Int) async throws -> T
    func getFixturesSearch<T: Decodable>(by query: String, page: Int) async throws -> T
    func getUpcomingFixturesByMarketID<T: Decodable>(_ marketID: Int, page: Int) async throws -> T
    func getUpcomingFixturesByTVStationID<T: Decodable>(_ tvStationID: Int, page: Int) async throws -> T
    func getPastFixturesByTVStationID<T: Decodable>(_ tvStationID: Int, page: Int) async throws -> T
    func getFixturesByLastUpdatedFixtures<T: Decodable>(page: Int) async throws -> T

}

public struct FixturesService: APIClient, FixturesServiceable {
    
    public var environment: Football.Environment
    
    public var session: URLSession
    
    private static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        //decoder.dateDecodingStrategy = .iso8601
        //decoder.dateDecodingStrategy = .millisecondsSince1970
        return decoder
    }
    
    public init(session: URLSession = URLSession.shared, environment: Football.Environment = .develop(apiToken: DemoAPIKeys.sportMonksToken)) {
        self.environment = environment
        self.session = session
    }
    
    public func getAllFixtures<T>(page: Int) async throws -> T where T : Decodable {
        try await asyncFetchRequest(Football.Fixtures.allFixtures(page: page), in: environment, decoder: FixturesService.decoder)
    }
    
    public func getFixtureByID<T>(_ id: Int) async throws -> T where T : Decodable {
        try await asyncFetchRequest(Football.Fixtures.fixtureByID(id), in: environment, decoder: FixturesService.decoder)
    }
    
    public func getFixturesByMultipleIDs<T>(_ ids: [Int], page: Int) async throws -> T where T : Decodable {
        try await asyncFetchRequest(Football.Fixtures.fixturesByMultipleIDs(ids, page: page), in: environment, decoder: FixturesService.decoder)
    }
    
    public func getFixturesByDate<T>(_ date: String, page: Int) async throws -> T where T : Decodable {
        try await asyncFetchRequest(Football.Fixtures.fixturesByDate(date, page: page), in: environment, decoder: FixturesService.decoder)
    }
    
    public func getFixturesByDateRange<T>(startDate: String, endDate: String, page: Int) async throws -> T where T : Decodable {
        try await asyncFetchRequest(Football.Fixtures.fixturesByDateRange(startDate: startDate, endDate: endDate, page: page), in: environment, decoder: FixturesService.decoder)
    }
    
    public func getFixturesByDateRangeForTeam<T>(startDate: String, endDate: String, teamID: Int, page: Int) async throws -> T where T : Decodable {
        try await asyncFetchRequest(Football.Fixtures.fixturesByDateRangeForTeam(startDate: startDate, endDate: endDate, teamID: teamID, page: page), in: environment, decoder: FixturesService.decoder)
    }
    
    public func getFixturesByHeadToHead<T>(teamID1: Int, teamID2: Int, page: Int) async throws -> T where T : Decodable {
        try await asyncFetchRequest(Football.Fixtures.fixturesByHeadToHead(teamID1: teamID1, teamID2: teamID2, page: page), in: environment, decoder: FixturesService.decoder)
    }
    
    public func getFixturesSearch<T>(by query: String, page: Int) async throws -> T where T : Decodable {
        try await asyncFetchRequest(Football.Fixtures.fixturesSearch(query: query, page: page), in: environment, decoder: FixturesService.decoder)
    }
    
    public func getUpcomingFixturesByMarketID<T>(_ marketID: Int, page: Int) async throws -> T where T : Decodable {
        try await asyncFetchRequest(Football.Fixtures.upcomingFixturesByMarketID(marketID, page: page), in: environment, decoder: FixturesService.decoder)
    }
    
    public func getUpcomingFixturesByTVStationID<T>(_ tvStationID: Int, page: Int) async throws -> T where T : Decodable {
        try await asyncFetchRequest(Football.Fixtures.upcomingFixturesByTVStationID(tvStationID, page: page), in: environment, decoder: FixturesService.decoder)
    }
    
    public func getPastFixturesByTVStationID<T>(_ tvStationID: Int, page: Int) async throws -> T where T : Decodable {
        try await asyncFetchRequest(Football.Fixtures.pastFixturesByTVStationID(tvStationID, page: page), in: environment, decoder: FixturesService.decoder)
    }
    
    public func getFixturesByLastUpdatedFixtures<T>(page: Int) async throws -> T where T : Decodable {
        try await asyncFetchRequest(Football.Fixtures.fixturesByLastUpdatedFixtures(page: page), in: environment, decoder: FixturesService.decoder)
    }
}

public final class FixturesServiceMock: Mockable, FixturesServiceable {
    
    public init() {}
    
    public func getAllFixtures<T>(page: Int) async throws -> T where T : Decodable {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
    
    public func getFixtureByID<T>(_ id: Int) async throws -> T where T : Decodable {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
    
    public func getFixturesByMultipleIDs<T>(_ ids: [Int], page: Int) async throws -> T where T : Decodable {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
    
    public func getFixturesByDate<T>(_ date: String, page: Int) async throws -> T where T : Decodable {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
    
    public func getFixturesByDateRange<T>(startDate: String, endDate: String, page: Int) async throws -> T where T : Decodable {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
    
    public func getFixturesByDateRangeForTeam<T>(startDate: String, endDate: String, teamID: Int, page: Int) async throws -> T where T : Decodable {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
    
    public func getFixturesByHeadToHead<T>(teamID1: Int, teamID2: Int, page: Int) async throws -> T where T : Decodable {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
    
    public func getFixturesSearch<T>(by query: String, page: Int) async throws -> T where T : Decodable {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
    
    public func getUpcomingFixturesByMarketID<T>(_ marketID: Int, page: Int) async throws -> T where T : Decodable {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
    
    public func getUpcomingFixturesByTVStationID<T>(_ tvStationID: Int, page: Int) async throws -> T where T : Decodable {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
    
    public func getPastFixturesByTVStationID<T>(_ tvStationID: Int, page: Int) async throws -> T where T : Decodable {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
    
    public func getFixturesByLastUpdatedFixtures<T>(page: Int) async throws -> T where T : Decodable {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
}
