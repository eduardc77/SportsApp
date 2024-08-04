
public struct Player: Decodable, Hashable {
    public let id: Int
    public let sportId: Int?
    public let countryId: Int?
    public let nationalityId: Int?
    public let cityId: Int?
    public let positionId: Int?
    public let detailedPositionId: Int?
    public let typeId: Int?
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
    
    // Squad Related
    public let transferId: Int?
    public let playerId: Int?
    public let teamId: Int?
    public var start: String?
    public var end: String?
    public var captain: Bool?
    public var jerseyNumber: Int?
}

public struct PlayerResponseModel: Decodable {
    public let data: Player
    public let subscription: [Subscription]?
    public let rateLimit: RateLimit?
    public let timezone: String?
}

public struct PlayersResponseModel: Decodable {
    public let data: [Player]
    public let pagination: Pagination
    public let subscription: [Subscription]?
    public let rateLimit: RateLimit
    public let timezone: String
}
