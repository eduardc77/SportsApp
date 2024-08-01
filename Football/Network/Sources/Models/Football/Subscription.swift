
public struct Subscription: Decodable {
    public let meta: Meta?
    public let plans: [Plan]?
}

public struct Plan: Decodable {
    public let plan: String?
    public let sport: String?
    public let category: String?
}

public struct Meta: Decodable {
    public let trialEndsAt: String?
    public let endsAt: String?
    public let currentTimestamp: Int?
}
