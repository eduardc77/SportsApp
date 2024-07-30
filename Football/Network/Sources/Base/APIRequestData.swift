
import Foundation

/**
 This protocol can be implemented by types that will provide
 request data when creating a `URLRequest`.

 Make sure to specify raw data values, then encode them when
 creating the request. This is automatically done when using
 an ``APIClient`` to perform requests.
 */
public protocol APIRequestData {

    /// Optional header parameters.
    var headers: [String: String]? { get }

    /// Optional query params.
    var queryParams: [String: String]? { get }
}

public extension APIRequestData {

    /// Convert ``queryParams`` to url encoded query items.
    var encodedQueryItems: [URLQueryItem]? {
        queryParams?
            .map { URLQueryItem(name: $0.key, value: $0.value) }
            .sorted { $0.name < $1.name }
    }
    
    /// Default value.
    var headers: [String: String]? { return nil }

    /// Default value.
    var queryParams: [String: String]? { return nil }
}
