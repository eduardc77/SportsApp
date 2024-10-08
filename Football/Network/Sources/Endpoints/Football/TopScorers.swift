
extension Football {
    
    /// This enum defines the currently supported API routes.
    enum TopScorers: APIRoute {
        
        case topScorersBySeasonID(_ seasonID: Int, page: Int)
        case topScorersByStageID(_ stageID: Int, page: Int)
    }
}

extension Football.TopScorers {
    
    var path: String {
        switch self {
        case .topScorersBySeasonID(let seasonID, _):
            return "/topscorers/seasons/\(seasonID)"
        case .topScorersByStageID(let stageID, _):
            return "/topscorers/stages/\(stageID)"
        }
    }
    
    var queryParams: [String: String]? {
        switch self {
        case .topScorersBySeasonID(_ , let page):
            return ["page": "\(page)", "include": "participant; player"]
        case .topScorersByStageID(_ , let page):
            return ["page": "\(page)", "include": "participant; player"]
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .topScorersBySeasonID, .topScorersByStageID:
            return .get
        }
    }
    
    var mockFile: String? {
        nil
    }
}
