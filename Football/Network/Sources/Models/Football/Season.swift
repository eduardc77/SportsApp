
public struct Season: Decodable, Hashable {
    public let id: Int
    public let sportId: Int?
    public let leagueId: Int?
    public let tieBreakerRuleId: Int?
    public let name: String?
    public let finished: Bool?
    public let pending: Bool?
    public let isCurrent: Bool?
    public let standingMethod: String?
    public let startingAt: String?
    public let endingAt: String?
}

public struct SeasonsResponseModel: Decodable {
    public let data: [Season]
    public let pagination: Pagination
    public let subscription: [Subscription]?
    public let rateLimit: RateLimit
    public let timezone: String
}
