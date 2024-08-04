
public extension Football {
    
    /// This enum defines the currently supported API routes.
    enum Stages: APIRoute {
        case allStages(page: Int)
        case stageByID(_ id: Int)
        case stageBySeasonID(_ id: Int, page: Int)
        case stagesSearch(query: String)
    }
}

public extension Football.Stages {
    
    var path: String {
        switch self {
        case .allStages:
            return "/stages"
        case .stageByID(let id):
            return "/stages/\(id)"
        case .stageBySeasonID(let seasonID, _):
            return "/stages/seasons/\(seasonID)"
        case .stagesSearch(let query):
            return "/stages/search/\(query)"
        }
    }
    
    var queryParams: [String: String]? {
        switch self {
        case .allStages(let page):
            return ["page": "\(page)"]
        case .stageByID:
            return nil
        case .stageBySeasonID:
            return nil
        case .stagesSearch:
            return nil
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .allStages, .stageByID, .stageBySeasonID, .stagesSearch:
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
