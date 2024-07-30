
import Foundation

/**
 This protocol can be implemented to define API routes.

 An ``APIRoute`` must define an ``httpMethod`` as well as an
 environment-relative path, headers, query params, data, etc.
 
 You can use an enum to define routes, and associated values
 to provide route-specific parameters.

 When a route defines ``formParams``, the URL request should
 use `application/x-www-form-urlencoded` as content type and
 ignore the ``uploadData``. The two are mutually exclusive and
 ``formParams`` should take precedence when both are defined.
 
 Both ``APIEnvironment`` and ``APIRoute`` can define headers
 and query parameters. An environment can use this to define
 global data, while a route defines route-specific data.
 */
public protocol APIRoute: APIRequestData {

    /// The HTTP method to use for the route.
    var httpMethod: HTTPMethod { get }

    /// The route's ``ApiEnvironment`` relative path.
    var path: String { get }
    
    var token: String? { get }

    /// Optional form data, which is sent as request body.
    var formParams: [String: String]? { get }
    
    /// Optional upload data, which is sent as request body.
    var uploadData: Data? { get }
    
    var mockFile: String? { get }
}

extension APIRoute {
    
    // Default values
    public var token: String? { nil }
    
    public var headers: [String: String]? { nil }
    
    public var formParams: [String: String]? { nil }
    
    public var uploadData: Data? { nil }
}

public extension APIRoute {

    /// Convert ``encodedFormItems`` to `.utf8` encoded data.
    var encodedFormData: Data? {
        guard let formParams, !formParams.isEmpty else { return nil }
        var params = URLComponents()
        params.queryItems = encodedFormItems
        let paramString = params.query
        return paramString?.data(using: .utf8)
    }

    /// Convert ``formParams`` to form encoded query items.
    var encodedFormItems: [URLQueryItem]? {
        formParams?
            .map { URLQueryItem(name: $0.key, value: $0.value.formEncoded()) }
            .sorted { $0.name < $1.name }
    }

    /// Get a `URLRequest` for the route and its properties.
    func urlRequest(for env: APIEnvironment) throws -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = env.scheme
        urlComponents.host = env.baseURL
        if !env.apiVersion.isEmpty {
            urlComponents.path = env.apiVersion + path
        } else {
            urlComponents.path = path
        }
        urlComponents.queryItems = queryItems(for: env)

        guard let requestURL = urlComponents.url else { throw APIError.invalidURLInComponents(urlComponents) }
        var request = URLRequest(url: requestURL)
        let formData = encodedFormData
        request.allHTTPHeaderFields = headers(for: env)
        request.httpBody = formData ?? uploadData
        request.httpMethod = httpMethod.method
        
        if let token = token {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        let isFormRequest = formData != nil
        let contentType = isFormRequest ? "application/x-www-form-urlencoded" : "application/json"
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        return request
    }
}

public extension APIEnvironment {

    /// Get a `URLRequest` for a certain ``ApiRoute``.
    func urlRequest(for route: APIRoute) throws -> URLRequest {
        try route.urlRequest(for: self)
    }
}

private extension APIRoute {

    func headers(for env: APIEnvironment) -> [String: String] {
        var result = env.headers ?? [:]
        headers?.forEach {
            result[$0.key] = $0.value
        }
        return result
    }

    func queryItems(for env: APIEnvironment) -> [URLQueryItem] {
        let routeData = encodedQueryItems ?? []
        let envData = env.encodedQueryItems ?? []
        return routeData + envData
    }

    func urlComponents(from url: URL) -> URLComponents? {
        URLComponents(url: url, resolvingAgainstBaseURL: true)
    }
}
