import Foundation

public protocol TopScorersServiceable {
    
    func getTopScorersBySeasonID<T: Decodable>(_ seasonID: Int, currentPage: Int) async throws -> T
    func getTopScorersByStageID<T: Decodable>(_ stageID: Int, currentPage: Int) async throws -> T
}

public struct TopScorersService: APIClient, TopScorersServiceable {
    
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
    
    public func getTopScorersBySeasonID<T: Decodable>(_ seasonID: Int, currentPage: Int) async throws -> T {
        try await asyncFetchRequest(Football.TopScorers.topScorersBySeasonID(seasonID, page: currentPage), in: environment, decoder: TopScorersService.decoder)
    }
    
    public func getTopScorersByStageID<T: Decodable>(_ stageID: Int, currentPage: Int) async throws -> T {
        try await asyncFetchRequest(Football.TopScorers.topScorersByStageID(stageID, page: currentPage), in: environment, decoder: TopScorersService.decoder)
    }
}

public final class TopScorersServiceMock: Mockable, TopScorersServiceable {
    
    public init() {}
    
    public func getTopScorersBySeasonID<T: Decodable>(_ seasonID: Int, currentPage: Int) async throws -> T {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
    
    public func getTopScorersByStageID<T: Decodable>(_ stageID: Int, currentPage: Int) async throws -> T {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
}
