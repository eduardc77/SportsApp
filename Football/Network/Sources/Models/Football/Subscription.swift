
public struct Subscription: Decodable {
    public let meta: [String]
    public let plans: [Plan]
    public let addOns: [String]
    public let widgets: [String]
}

public struct Plan: Decodable {
    public let plan: String
    public let sport: String
    public let category: String
}
