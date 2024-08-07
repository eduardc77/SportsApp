
import Foundation

public protocol SeasonsServiceable {
    
    func getAllSeasons<T: Decodable>(currentPage: Int) async throws -> T
    func getSeasonByID<T: Decodable>(_ id: Int, currentPage: Int) async throws -> T
    func getSeasonsByTeamID<T: Decodable>(_ teamID: Int, currentPage: Int) async throws -> T
    func getSeasonsSearch<T: Decodable>(by query: String) async throws -> T
}

public struct SeasonsService: APIClient, SeasonsServiceable {
    
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
    
    public func getAllSeasons<T: Decodable>(currentPage: Int) async throws -> T {
        try await asyncFetchRequest(Football.Seasons.allSeasons(page: currentPage), in: environment, decoder: SeasonsService.decoder)
    }
    
    public func getSeasonByID<T: Decodable>(_ id: Int, currentPage: Int) async throws -> T {
        try await asyncFetchRequest(Football.Seasons.seasonByID(id), in: environment, decoder: SeasonsService.decoder)
    }
    
    public func getSeasonsByTeamID<T: Decodable>(_ teamID: Int, currentPage: Int) async throws -> T {
        try await asyncFetchRequest(Football.Seasons.seasonsByTeamID(teamID, page: currentPage), in: environment, decoder: SeasonsService.decoder)
    }
    
    public func getSeasonsSearch<T: Decodable>(by query: String) async throws -> T {
        try await asyncFetchRequest(Football.Seasons.seasonsSearch(query: query), in: environment, decoder: SeasonsService.decoder)
    }
}

public final class SeasonsServiceMock: Mockable, SeasonsServiceable {
    
    public init() {}
    
    public func getAllSeasons<T: Decodable>(currentPage: Int) async throws -> T {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
    
    public func getSeasonByID<T: Decodable>(_ id: Int, currentPage: Int) async throws -> T {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
    
    public func getSeasonsByTeamID<T>(_ teamID: Int, currentPage: Int) async throws -> T where T : Decodable {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
    
    public func getSeasonsSearch<T: Decodable>(by query: String) async throws -> T {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
}
