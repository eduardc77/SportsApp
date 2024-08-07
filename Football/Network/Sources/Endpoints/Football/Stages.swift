
public extension Football {
    
    /// This enum defines the currently supported API routes.
    enum Stages: APIRoute {
        case allStages(page: Int)
        case stageByID(_ id: Int)
        case stagesBySeasonID(_ id: Int)
        case stagesSearch(query: String, page: Int)
    }
}

public extension Football.Stages {
    
    var path: String {
        switch self {
        case .allStages:
            return "/stages"
        case .stageByID(let id):
            return "/stages/\(id)"
        case .stagesBySeasonID(let seasonID):
            return "/stages/seasons/\(seasonID)"
        case .stagesSearch(let query, _):
            return "/stages/search/\(query)"
        }
    }
    
    var queryParams: [String: String]? {
        switch self {
        case .allStages(let page):
            return ["page": "\(page)", "include": "rounds; currentRound; fixtures"]
        case .stageByID:
            return ["include": "rounds; currentRound; fixtures"]
        case .stagesBySeasonID:
            return ["include": "rounds; currentRound; fixtures"]
        case .stagesSearch(_, let page):
            return ["page": "\(page)", "include": "rounds; currentRound; fixtures"]
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .allStages, .stageByID, .stagesBySeasonID, .stagesSearch:
            return .get
        }
    }
    
    var mockFile: String? {
        switch self {
        case .allStages:
            return "_mockStagesResponse"
        default: return ""
        }
    }
}
