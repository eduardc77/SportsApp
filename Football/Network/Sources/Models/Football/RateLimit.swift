
public struct RateLimit: Decodable {
    public let resetsInSeconds: Int
    public let remaining: Int
    public let requestedEntity: String
}
