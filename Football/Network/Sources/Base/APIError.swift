
import Foundation

/**
 This enum defines api-specific errors that can occur when a
 client communicates with an external API.
 */
enum APIError: Error, Equatable, LocalizedError {

    /// This error should be thrown when a `URLRequest` will
    /// fail to be created due to invalid `URLComponents`.
    case invalidURLInComponents(URLComponents)
    
    case fetchRequestError(error: String)
    case invalidUploadData
    case downloadError(String)
    case uploadError(String)
    case invalidHTTPResponse
    case decodingDataError
    case serverError(String)
    case unknownError(code: Int, description: String)
}

extension APIError {
    
    var isInvalidResponseStatusCode: Bool { self == .invalidHTTPResponse }
    var isDecodingDataError: Bool { self == .decodingDataError }
}

extension APIError {
    
    var errorDescription: String? {
        switch self {
        case .invalidURLInComponents(let urlComponents):
            return NSLocalizedString("Received invalid url error from components: \(urlComponents)", comment: "")
        case .fetchRequestError(let error):
            return NSLocalizedString("Received fetch request error. \(error)", comment: "")
        case .invalidUploadData:
            return NSLocalizedString("Received invalid upload data error", comment: "")
        case .downloadError(let error):
            return NSLocalizedString("Received download error. \(error)", comment: "")
        case .uploadError(let error):
            return NSLocalizedString("Received upload error. \(error)", comment: "")
        case .invalidHTTPResponse:
            return NSLocalizedString("Received invalid http response error.", comment: "")
        case .decodingDataError:
            return NSLocalizedString("Received decoding data error.", comment: "")
        case .serverError(let error):
            return NSLocalizedString("Received server error. \(error)", comment: "")
        case .unknownError(let errorCode, let errorDescription):
            return NSLocalizedString("Received unknown error \(errorCode). \(errorDescription)", comment: "")
        }
    }
}


/**
 Model for Server Error
 */
struct ServerError: Codable {
    let code: Int
    let message: String

    enum CodingKeys: String, CodingKey {
        case code
        case message
    }
}
