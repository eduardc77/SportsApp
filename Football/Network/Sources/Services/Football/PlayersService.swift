
import Foundation

public protocol PlayersServiceable {
    
    func getAllPlayers<T: Decodable>(currentPage: Int) async throws -> T
    func getPlayerByID<T: Decodable>(_ id: Int) async throws -> T
    func getPlayersByCountryID<T: Decodable>(_ countryID: Int) async throws -> T
    func getPlayersSearch<T: Decodable>(by query: String) async throws -> T
    func getLastUpdatedPlayers<T: Decodable>() async throws -> T
}

public struct PlayersService: APIClient, PlayersServiceable {

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
    
    public func getAllPlayers<T: Decodable>(currentPage: Int) async throws -> T {
        try await asyncFetchRequest(Football.Players.allPlayers(page: currentPage), in: environment, decoder: PlayersService.decoder)
    }
    
    public func getPlayerByID<T: Decodable>(_ id: Int) async throws -> T {
        try await asyncFetchRequest(Football.Players.playerByID(id), in: environment, decoder: PlayersService.decoder)
    }
    
    public func getPlayersByCountryID<T: Decodable>(_ countryID: Int) async throws -> T {
        try await asyncFetchRequest(Football.Players.playersByCountryID(countryID), in: environment, decoder: PlayersService.decoder)
    }

    public func getPlayersSearch<T: Decodable>(by query: String) async throws -> T {
        try await asyncFetchRequest(Football.Players.playersSearch(query: query), in: environment, decoder: PlayersService.decoder)
    }
    
    public func getLastUpdatedPlayers<T: Decodable>() async throws -> T {
        try await asyncFetchRequest(Football.Players.lastUpdatedPlayers, in: environment, decoder: PlayersService.decoder)
    }
}

public final class PlayersServiceMock: Mockable, PlayersServiceable {

    public init() {}
    
    public func getAllPlayers<T: Decodable>(currentPage: Int) async throws -> T {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
    
    public func getPlayerByID<T: Decodable>(_ id: Int) async throws -> T {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
    
    public func getPlayersByCountryID<T: Decodable>(_ countryID: Int) async throws -> T {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
    
    public func getLeagueBySeasonID<T: Decodable>(_ seasonID: Int) async throws -> T {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
    
    public func getPlayersSearch<T: Decodable>(by query: String) async throws -> T {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
    
    public func getLastUpdatedPlayers<T: Decodable>() async throws -> T {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
}
