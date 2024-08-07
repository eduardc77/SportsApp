
public struct TopScorer: Decodable, Hashable {
    public let id: Int
    public let leagueId: Int?
    public let seasonId: Int?
    public let stageId: Int?
    public let playerId: Int?
    public let participantId: Int?
    public let typeId: Int?
    public let position: Int?
    public let total: Int?
    public let participantType: String?
    public let participant: Team?
    public let player: Player?
}

public struct TopScorersResponseModel: Decodable {
    public let data: [TopScorer]
    public let pagination: Pagination?
    public let subscription: [Subscription]?
    public let rateLimit: RateLimit
    public let timezone: String
}
