
import Foundation

public protocol LeaguesServiceable {
    
    func getAllLeagues<T: Decodable>(currentPage: Int) async throws -> T
    func getLeagueByID<T: Decodable>(_ id: Int) async throws -> T
    func getLeaguesLive<T: Decodable>() async throws -> T
    func getLeagueByFixtureDate<T: Decodable>(date: String) async throws -> T
    func getLeagueByCountryID<T: Decodable>(_ countryID: Int) async throws -> T
    func leagueSearch<T: Decodable>(query: String) async throws -> T
    
}

public struct LeaguesService: APIClient, LeaguesServiceable {
    
    public var environment: Football.Environment
    
    public var session: URLSession
    
    private var decoder: JSONDecoder {
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
    
    public func getAllLeagues<T>(currentPage: Int) async throws -> T where T : Decodable {
        try await asyncFetchRequest(Football.Leagues.allLeagues(page: currentPage), in: environment, decoder: decoder)
    }
    
    public func getLeagueByID<T: Decodable>(_ id: Int) async throws -> T {
        try await asyncFetchRequest(Football.Leagues.leagueByID(id), in: environment)
    }
    
    public func getLeaguesLive<T: Decodable>() async throws -> T {
        try await asyncFetchRequest(Football.Leagues.leagueLive, in: environment)
    }
    
    public func getLeagueByFixtureDate<T>(date: String) async throws -> T where T : Decodable {
        try await asyncFetchRequest(Football.Leagues.leagueByFixtureDate(date: date), in: environment)
    }
    
    public func getLeagueByCountryID<T: Decodable>(_ countryID: Int) async throws -> T {
        try await asyncFetchRequest(Football.Leagues.leagueByCountryID(countryID), in: environment)
    }
    
    public func leagueSearch<T: Decodable>(query: String) async throws -> T {
        try await asyncFetchRequest(Football.Leagues.leaguesSearch(query: query), in: environment)
    }
}


public final class LeaguesServiceMock: Mockable, LeaguesServiceable {
    
    public init() {}
    
    public func getAllLeagues<T>(currentPage: Int) async throws -> T where T : Decodable {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
    
    public func getLeagueByID<T: Decodable>(_ id: Int) async throws -> T {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
    
    public func getLeaguesLive<T: Decodable>() async throws -> T {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
    
    public func getLeagueByFixtureDate<T>(date: String) async throws -> T where T : Decodable {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
    
    public func getLeagueByCountryID<T: Decodable>(_ countryID: Int) async throws -> T {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
    
    public func leagueSearch<T: Decodable>(query: String) async throws -> T {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
}
