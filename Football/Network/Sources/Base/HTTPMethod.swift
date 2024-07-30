
/**
 This enum defines various HTTP methods.
 */
public enum HTTPMethod: String, CaseIterable, Identifiable {

    case connect
    case delete
    case get
    case head
    case options
    case patch
    case post
    case put
    case trace

    /// The unique HTTP method identifier.
    public var id: String { rawValue }

    /// The uppercased HTTP method name.
    public var method: String { id.uppercased() }
}


/**
 Enum for Content Types
 */
enum ContentType: String {
    case json = "application/json"
}
/**
 Enum for Authe Types
 */
enum AuthType: String {
    case bearer = "Bearer"
}
/**
 Enum for HTTP Heeader Fields
 */
enum HTTPHeaderField: String {
    case contentType = "Content-Type"
    case authorization = "Authorization"
}
