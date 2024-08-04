
import Foundation

public protocol LeaguesServiceable {
    
    func getAllLeagues<T: Decodable>(currentPage: Int) async throws -> T
    func getLeagueByID<T: Decodable>(_ id: Int) async throws -> T
    func getLeaguesLive<T: Decodable>() async throws -> T
    func getLeagueByFixtureDate<T: Decodable>(date: String) async throws -> T
    func getLeaguesByCountryID<T: Decodable>(_ countryID: Int) async throws -> T
    func getLeagueSearch<T: Decodable>(by query: String) async throws -> T
}

public struct LeaguesService: APIClient, LeaguesServiceable {
    
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
    
    public func getAllLeagues<T: Decodable>(currentPage: Int) async throws -> T {
        try await asyncFetchRequest(Football.Leagues.allLeagues(page: currentPage), in: environment, decoder: LeaguesService.decoder)
    }
    
    public func getLeagueByID<T: Decodable>(_ id: Int) async throws -> T {
        try await asyncFetchRequest(Football.Leagues.leagueByID(id), in: environment, decoder: LeaguesService.decoder)
    }
    
    public func getLeaguesLive<T: Decodable>() async throws -> T {
        try await asyncFetchRequest(Football.Leagues.leagueLive, in: environment, decoder: LeaguesService.decoder)
    }
    
    public func getLeagueByFixtureDate<T>(date: String) async throws -> T where T : Decodable {
        try await asyncFetchRequest(Football.Leagues.leagueByFixtureDate(date: date), in: environment, decoder: LeaguesService.decoder)
    }
    
    public func getLeaguesByCountryID<T: Decodable>(_ countryID: Int) async throws -> T {
        try await asyncFetchRequest(Football.Leagues.leagueByCountryID(countryID), in: environment, decoder: LeaguesService.decoder)
    }
    
    public func getLeagueSearch<T: Decodable>(by query: String) async throws -> T {
        try await asyncFetchRequest(Football.Leagues.leaguesSearch(query: query), in: environment, decoder: LeaguesService.decoder)
    }
}

public final class LeaguesServiceMock: Mockable, LeaguesServiceable {
    
    public init() {}
    
    public func getAllLeagues<T: Decodable>(currentPage: Int) async throws -> T {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
    
    public func getLeagueByID<T: Decodable>(_ id: Int) async throws -> T {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
    
    public func getLeaguesLive<T: Decodable>() async throws -> T {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
    
    public func getLeagueByFixtureDate<T: Decodable>(date: String) async throws -> T {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
    
    public func getLeaguesByCountryID<T: Decodable>(_ countryID: Int) async throws -> T {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
    
    public func getLeagueSearch<T: Decodable>(by query: String) async throws -> T {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
}
