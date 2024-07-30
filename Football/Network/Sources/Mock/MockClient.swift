
import Foundation
import Combine

protocol Mockable: AnyObject {
    var bundle: Bundle { get }
    func loadJSON<T: Decodable>(filename: String, type: T.Type) -> T
}

extension Mockable {
    var bundle: Bundle {
        return Bundle(for: type(of: self))
    }

    func loadJSON<T: Decodable>(filename: String, type: T.Type) -> T {
        guard let path = bundle.url(forResource: filename, withExtension: "json") else {
            fatalError("Failed to load JSON")
        }

        do {
            let data = try Data(contentsOf: path)
            let decodedObject = try JSONDecoder().decode(type, from: data)

            return decodedObject
        } catch {
            fatalError("Failed to decode loaded JSON")
        }
    }
}

open class MockClient: Mockable, APIClient {

    var sendError: Bool
    var mockFile: String?

    public init(sendError: Bool = false, mockFile: String? = "dd") {
        self.sendError = sendError
        self.mockFile = mockFile
    }

    public func asyncFetchRequest<T: Decodable>(_ route: APIRoute, in: APIEnvironment) async throws -> T {
        if sendError {
            throw APIError.fetchRequestError(error: "Mock Fetch Request Failed.")
        } else {
            let filename = mockFile ?? route.mockFile!
            return loadJSON(filename: filename, type: T.self)
        }
    }

    public func combineFetchRequest<T: Decodable>(_ route: APIRoute, in: APIEnvironment) -> AnyPublisher<T, Error> {
        if sendError {
            return Fail(error: APIError.fetchRequestError(error: "Mock Fetch Request Failed."))
                .eraseToAnyPublisher()
        } else {
            let filename = mockFile ?? route.mockFile!
            return Just(loadJSON(filename: filename, type: T.self) as T)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }

    public func asyncUpload<T: Decodable>(_ route: APIRoute, in: APIEnvironment) async throws -> T {
        if sendError {
            throw APIError.uploadError("Mock Upload Request Failed.")
        } else {
            let filename = mockFile ?? route.mockFile!
            return loadJSON(filename: filename, type: T.self)
        }
    }

    public func asyncDownload(fileURL: URL) async throws -> URL {
        if sendError {
            throw APIError.downloadError("Async download Failed.")
        } else {
            let fileURL = URL(string: "file:///users/mock/avatar.jpg")!
            return fileURL
        }
    }

    public func asyncDownload(_ route: APIRoute, in: APIEnvironment) async throws -> URL {
        if sendError {
            throw APIError.downloadError("Async download Failed.")
        } else {
            let fileURL = URL(string: "file:///users/mock/avatar.jpg")!
            return fileURL
        }
    }
}

public enum MockEnvironment: APIEnvironment {
    case mock
}
