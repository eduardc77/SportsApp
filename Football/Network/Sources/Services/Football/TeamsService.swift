
import Foundation

public protocol TeamsServiceable {
    
    func getAllTeams<T: Decodable>(currentPage: Int) async throws -> T
    func getTeamByID<T: Decodable>(_ id: Int) async throws -> T
    func getLeagueByCountryID<T: Decodable>(_ countryID: Int) async throws -> T
    func getLeagueBySeasonID<T: Decodable>(_ seasonID: Int) async throws -> T
    func teamSearch<T: Decodable>(query: String) async throws -> T
    
}

public struct TeamsService: APIClient, TeamsServiceable {
    
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
    
    public func getAllTeams<T>(currentPage: Int) async throws -> T where T : Decodable {
        try await asyncFetchRequest(Football.Teams.allTeams(page: currentPage), in: environment, decoder: decoder)
    }
    
    public func getTeamByID<T: Decodable>(_ id: Int) async throws -> T {
        try await asyncFetchRequest(Football.Teams.teamByID(id), in: environment)
    }
    
    public func getLeagueByCountryID<T: Decodable>(_ countryID: Int) async throws -> T {
        try await asyncFetchRequest(Football.Teams.teamByCountryID(countryID), in: environment)
    }
    
    public func getLeagueBySeasonID<T>(_ seasonID: Int) async throws -> T where T : Decodable {
        try await asyncFetchRequest(Football.Teams.teamBySeasonID(seasonID), in: environment)
    }
    
    public func teamSearch<T: Decodable>(query: String) async throws -> T {
        try await asyncFetchRequest(Football.Teams.teamSearch(query: query), in: environment)
    }
}


public final class TeamsServiceMock: Mockable, TeamsServiceable {
    
    public init() {}
    
    public func getAllTeams<T>(currentPage: Int) async throws -> T where T : Decodable {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
    
    public func getTeamByID<T: Decodable>(_ id: Int) async throws -> T {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
    
    public func getLeagueByCountryID<T: Decodable>(_ countryID: Int) async throws -> T {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
    
    public func getLeagueBySeasonID<T>(_ seasonID: Int) async throws -> T where T : Decodable {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
    
    public func teamSearch<T: Decodable>(query: String) async throws -> T {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
}
