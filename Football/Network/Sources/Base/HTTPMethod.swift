
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
