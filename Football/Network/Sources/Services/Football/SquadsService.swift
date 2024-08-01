
import Foundation

public protocol SquadsServiceable {
    
    func getSquadsByTeamID<T: Decodable>(_ teamID: Int, currentPage: Int) async throws -> T
    func getExtendedSquadByTeamID<T: Decodable>(_ teamID: Int, currentPage: Int) async throws -> T
    func getSquadsBySeasonID<T: Decodable>(_ seasonID: Int, teamID: Int, currentPage: Int) async throws -> T
}

public struct SquadsService: APIClient, SquadsServiceable {
    
    public var environment: Football.Environment
    
    public var session: URLSession
    
    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    public init(session: URLSession = URLSession.shared, environment: Football.Environment = .develop(apiToken: DemoAPIKeys.sportMonksToken)) {
        self.environment = environment
        self.session = session
    }
    
    public func getSquadsByTeamID<T>(_ teamID: Int, currentPage: Int) async throws -> T where T : Decodable {
        try await asyncFetchRequest(Football.Squads.squadsByTeamID(teamID, page: currentPage), in: environment, decoder: decoder)
    }
    
    public func getExtendedSquadByTeamID<T: Decodable>(_ teamID: Int, currentPage: Int) async throws -> T {
        try await asyncFetchRequest(Football.Squads.extendedSquadByTeamID(teamID, page: currentPage), in: environment)
    }

    public func getSquadsBySeasonID<T>(_ seasonID: Int, teamID: Int, currentPage: Int) async throws -> T where T : Decodable {
        try await asyncFetchRequest(Football.Squads.squadsBySeasonID(seasonID, teamID: teamID, page: currentPage), in: environment)
    }
}

public final class SquadsServiceMock: Mockable, SquadsServiceable {
    
    public init() {}
    
    public func getSquadsByTeamID<T>(_ teamID: Int, currentPage: Int) async throws -> T where T : Decodable {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
    
    public func getExtendedSquadByTeamID<T: Decodable>(_ teamID: Int, currentPage: Int) async throws -> T {
        loadJSON(filename: "top_rated_response", type: T.self)
    }

    public func getSquadsBySeasonID<T>(_ seasonID: Int, teamID: Int, currentPage: Int) async throws -> T where T : Decodable {
        loadJSON(filename: "top_rated_response", type: T.self)
    }
}
