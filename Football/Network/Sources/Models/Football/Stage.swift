
public struct Stage: Decodable, Hashable {
    public let id: Int
    public let sportId: Int?
    public let leagueId: Int?
    public let seasonId: Int?
    public let typeId: Int?
    public let name: String?
    public let sortOrder: Int?
    public let finished: Bool?
    public let pending: Bool?
    public let isCurrent: Bool?
    public let startingAt: String?
    public let endingAt: String?
}

public struct StagesResponseModel: Decodable {
    public let data: [Stage]
    public let pagination: Pagination
    public let subscription: [Subscription]?
    public let rateLimit: RateLimit
    public let timezone: String
}
