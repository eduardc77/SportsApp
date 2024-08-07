
public struct Round: Decodable, Hashable {
    public let id: Int
    public let sportId: Int?
    public let leagueId: Int?
    public let seasonId: Int?
    public let stageId: Int?
    public let name: String?
    public let finished: Bool?
    public let pending: Bool?
    public let isCurrent: Bool?
    public let startingAt: String?
    public let endingAt: String?
    public let gamesInCurrentWeek: Bool?
    public let fixtures: [Fixture]?
}

public struct RoundsResponseModel: Decodable {
    public let data: [Round]
    public let pagination: Pagination?
    public let subscription: [Subscription]?
    public let rateLimit: RateLimit
    public let timezone: String
}
