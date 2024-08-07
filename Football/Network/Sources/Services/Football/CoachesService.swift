
import Foundation

public protocol CoachesServiceable {
    
    func getAllCoaches<T: Decodable>(currentPage: Int) async throws -> T
    func getCoachByID<T: Decodable>(_ id: Int) async throws -> T
    func getCoachesByCountryID<T: Decodable>(_ countryID: Int) async throws -> T
    func getCoachesSearch<T: Decodable>(by query: String) async throws -> T
    func getLastUpdatedCoaches<T: Decodable>() async throws -> T
}

public struct CoachesService: APIClient, CoachesServiceable {
    
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
    
    public func getAllCoaches<T: Decodable>(currentPage: Int) async throws -> T {
        try await asyncFetchRequest(Football.Coaches.allCoaches(page: currentPage), in: environment, decoder: CoachesService.decoder)
    }
    
    public func getCoachByID<T: Decodable>(_ id: Int) async throws -> T {
        try await asyncFetchRequest(Football.Coaches.coachesByID(id), in: environment, decoder: CoachesService.decoder)
    }
    
    public func getCoachesByCountryID<T: Decodable>(_ countryID: Int) async throws -> T {
        try await asyncFetchRequest(Football.Coaches.coachesByCountryID(countryID), in: environment, decoder: CoachesService.decoder)
    }
    
    public func getCoachesSearch<T: Decodable>(by query: String) async throws -> T {
        try await asyncFetchRequest(Football.Coaches.coachesSearch(query: query), in: environment, decoder: CoachesService.decoder)
    }
    
    public func getLastUpdatedCoaches<T: Decodable>() async throws -> T {
        try await asyncFetchRequest(Football.Coaches.lastUpdatedCoaches, in: environment, decoder: CoachesService.decoder)
    }
}

public final class CoachesServiceMock: Mockable, CoachesServiceable {
    
    public init() {}
    
    public func getAllCoaches<T: Decodable>(currentPage: Int) async throws -> T {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
    
    public func getCoachByID<T: Decodable>(_ id: Int) async throws -> T {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
    
    public func getCoachesByCountryID<T: Decodable>(_ countryID: Int) async throws -> T {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
    
    public func getCoachesSearch<T: Decodable>(by query: String) async throws -> T {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
    
    public func getLastUpdatedCoaches<T: Decodable>() async throws -> T {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
}
