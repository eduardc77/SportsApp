
import Foundation

public protocol TeamsServiceable {
    
    func getAllTeams<T: Decodable>(currentPage: Int) async throws -> T
    func getTeamByID<T: Decodable>(_ id: Int) async throws -> T
    func getTeamByCountryID<T: Decodable>(_ countryID: Int) async throws -> T
    func getTeamBySeasonID<T: Decodable>(_ seasonID: Int) async throws -> T
    func getTeamSearch<T: Decodable>(by query: String) async throws -> T
}

public struct TeamsService: APIClient, TeamsServiceable {
    
    public var environment: Football.Environment
    
    public var session: URLSession
    
    private static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    public init(session: URLSession = URLSession.shared, environment: Football.Environment = .develop(apiToken: DemoAPIKeys.sportMonksToken)) {
        self.environment = environment
        self.session = session
    }
    
    public func getAllTeams<T>(currentPage: Int) async throws -> T where T : Decodable {
        try await asyncFetchRequest(Football.Teams.allTeams(page: currentPage), in: environment, decoder: TeamsService.decoder)
    }
    
    public func getTeamByID<T: Decodable>(_ id: Int) async throws -> T {
        try await asyncFetchRequest(Football.Teams.teamByID(id), in: environment, decoder: TeamsService.decoder)
    }
    
    public func getTeamByCountryID<T: Decodable>(_ countryID: Int) async throws -> T {
        try await asyncFetchRequest(Football.Teams.teamByCountryID(countryID), in: environment, decoder: TeamsService.decoder)
    }
    
    public func getTeamBySeasonID<T>(_ seasonID: Int) async throws -> T where T : Decodable {
        try await asyncFetchRequest(Football.Teams.teamBySeasonID(seasonID), in: environment, decoder: TeamsService.decoder)
    }
    
    public func getTeamSearch<T: Decodable>(by query: String) async throws -> T {
        try await asyncFetchRequest(Football.Teams.teamSearch(query: query), in: environment, decoder: TeamsService.decoder)
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
    
    public func getTeamByCountryID<T: Decodable>(_ countryID: Int) async throws -> T {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
    
    public func getTeamBySeasonID<T>(_ seasonID: Int) async throws -> T where T : Decodable {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
    
    public func getTeamSearch<T: Decodable>(by query: String) async throws -> T {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
}
