
public struct League: Decodable {
    public let id: Int
    public let sportId: Int
    public let countryId: Int
    public let name: String
    public let active: Bool
    public let shortCode: String?
    public let imagePath: String
    public let type: String
    public let subType: String
    public let lastPlayedAt: String
    public let category: Int
    public let hasJerseys: Bool
}

public struct LeaguesResponseModel: Decodable {
    public let data: [League]
    public let pagination: Pagination
    public let subscription: [Subscription]
    public let rateLimit: RateLimit
    public let timezone: String
}
