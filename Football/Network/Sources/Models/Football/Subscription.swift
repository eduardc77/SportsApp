
public struct Subscription: Decodable {
    public let plans: [Plan]?
}

public struct Plan: Decodable {
    public let plan: String?
    public let sport: String?
    public let category: String?
}
