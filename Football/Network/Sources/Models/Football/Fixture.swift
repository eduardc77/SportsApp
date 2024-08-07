
public struct Fixture: Decodable, Hashable {
    public let id: Int
    public let sportId: Int?
    public let leagueId: Int?
    public let seasonId: Int?
    public let stageId: Int?
    public let groupId: Int?
    public let aggregateId: Int?
    public let roundId: Int?
    public let stateId: Int?
    public let venueId: Int?
    public let name: String?
    public let startingAt: String?
    public let resultInfo: String?
    public let leg: String?
    public let details: String?
    public let length: Int?
    public let hasOdds: Bool?
    public let startingAtTimestamp: Int?
    public let participants: [Team]?
}

public struct FixturesResponseModel: Decodable {
    public let data: [Fixture]
    public let pagination: Pagination?
    public let subscription: [Subscription]?
    public let rateLimit: RateLimit
    public let timezone: String
}
