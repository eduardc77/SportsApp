
public struct Pagination: Decodable {
    public let count: Int
    public let perPage: Int
    public let currentPage: Int
    public let nextPage: String?
    public let hasMore: Bool
}
