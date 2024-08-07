
import Foundation

public protocol RoundsServiceable {
    
    func getAllRounds<T: Decodable>(currentPage: Int) async throws -> T
    func getRoundByID<T: Decodable>(_ id: Int, currentPage: Int) async throws -> T
    func getRoundsBySeasonID<T: Decodable>(_ seasonID: Int) async throws -> T
    func getRoundsSearch<T: Decodable>(by query: String, currentPage: Int) async throws -> T
}

public struct RoundsService: APIClient, RoundsServiceable {
    
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
    
    public func getAllRounds<T: Decodable>(currentPage: Int) async throws -> T {
        try await asyncFetchRequest(Football.Rounds.allRounds(page: currentPage), in: environment, decoder: RoundsService.decoder)
    }
    
    public func getRoundByID<T: Decodable>(_ id: Int, currentPage: Int) async throws -> T {
        try await asyncFetchRequest(Football.Rounds.roundByID(id), in: environment, decoder: RoundsService.decoder)
    }
    
    public func getRoundsBySeasonID<T: Decodable>(_ seasonID: Int) async throws -> T {
        try await asyncFetchRequest(Football.Rounds.roundBySeasonID(seasonID), in: environment, decoder: RoundsService.decoder)
    }
    
    public func getRoundsSearch<T: Decodable>(by query: String, currentPage: Int) async throws -> T {
        try await asyncFetchRequest(Football.Rounds.roundsSearch(query: query, page: currentPage), in: environment, decoder: RoundsService.decoder)
    }
}

public final class RoundsServiceMock: Mockable, RoundsServiceable {
    
    public init() {}
    
    public func getAllRounds<T>(currentPage: Int) async throws -> T where T : Decodable {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
    
    public func getRoundByID<T>(_ id: Int, currentPage: Int) async throws -> T where T : Decodable {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
    
    public func getRoundsBySeasonID<T>(_ seasonID: Int) async throws -> T where T : Decodable {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
    
    public func getRoundsSearch<T>(by query: String, currentPage: Int) async throws -> T where T : Decodable {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
}
