
import Foundation

public protocol StagesServiceable {
    
    func getAllStages<T: Decodable>(currentPage: Int) async throws -> T
    func getStageByID<T: Decodable>(_ id: Int, currentPage: Int) async throws -> T
    func getStagesBySeasonID<T: Decodable>(_ seasonID: Int) async throws -> T
    func getStagesSearch<T: Decodable>(by query: String, currentPage: Int) async throws -> T
}

public struct StagesService: APIClient, StagesServiceable {
    
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
    
    public func getAllStages<T: Decodable>(currentPage: Int) async throws -> T {
        try await asyncFetchRequest(Football.Stages.allStages(page: currentPage), in: environment, decoder: StagesService.decoder)
    }
    
    public func getStageByID<T: Decodable>(_ id: Int, currentPage: Int) async throws -> T {
        try await asyncFetchRequest(Football.Stages.stageByID(id), in: environment, decoder: StagesService.decoder)
    }
    
    public func getStagesBySeasonID<T: Decodable>(_ seasonID: Int) async throws -> T {
        try await asyncFetchRequest(Football.Stages.stagesBySeasonID(seasonID), in: environment, decoder: StagesService.decoder)
    }
    
    public func getStagesSearch<T: Decodable>(by query: String, currentPage: Int) async throws -> T {
        try await asyncFetchRequest(Football.Stages.stagesSearch(query: query, page: currentPage), in: environment, decoder: StagesService.decoder)
    }
}

public final class StagesServiceMock: Mockable, StagesServiceable {
    
    public init() {}
    
    public func getAllStages<T: Decodable>(currentPage: Int) async throws -> T {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
    
    public func getStageByID<T: Decodable>(_ id: Int, currentPage: Int) async throws -> T {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
    
    public func getStagesBySeasonID<T: Decodable>(_ seasonID: Int) async throws -> T {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
    
    public func getStagesSearch<T: Decodable>(by query: String, currentPage: Int) async throws -> T {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
}
