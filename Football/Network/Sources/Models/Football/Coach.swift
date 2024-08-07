
public struct Coach: Decodable, Hashable {
    public let id: Int
    public let playerId: Int?
    public let sportId: Int?
    public let countryId: Int?
    public let nationalityId: Int?
    public let cityId: Int?
    public var commonName: String?
    public var firstname: String?
    public var lastname: String?
    public var name: String?
    public var displayName: String?
    public var imagePath: String?
    public var height: Int?
    public var weight: Int?
    public var dateOfBirth: String?
    public var gender: String?
}

public struct CoachResponseModel: Decodable {
    public let data: Coach
    public let subscription: [Subscription]?
    public let rateLimit: RateLimit?
    public let timezone: String?
}

public struct CoachesResponseModel: Decodable {
    public let data: [Coach]
    public let pagination: Pagination?
    public let subscription: [Subscription]?
    public let rateLimit: RateLimit
    public let timezone: String
}
