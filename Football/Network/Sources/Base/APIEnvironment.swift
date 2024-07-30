
import Foundation

/**
 This protocol can be implemented to define API environments
 or specific API versions.

 An ``APIEnvironment`` must define a root ``url`` to which a
 route ``ApiRoute/path`` can be applied.
 
 You can use enums to define environments and use associated
 values to provide environment-specific parameters.

 Both ``APIEnvironment`` and ``ApiRoute`` can define headers
 and query parameters. An environment can use this to define
 global data, while a route defines route-specific data.
 */
public protocol APIEnvironment: APIRequestData {

    var scheme: String { get }
    var baseURL: String { get }
    var apiVersion: String { get }
}

extension APIEnvironment {
    
    // Default  Values
    
    public var scheme: String { "https" }
    
    public var baseURL: String { "" }
    
    public var apiVersion: String { "" }
}
