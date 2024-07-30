
import Foundation
import Combine


public protocol APIClient {
    
    func asyncFetchRequest<T: Decodable>(_ route: APIRoute, in environment: APIEnvironment, session: URLSession, decoder: JSONDecoder) async throws -> T
    func combineFetchRequest<T: Decodable>(_ route: APIRoute, in environment: APIEnvironment, session: URLSession, decoder: JSONDecoder) -> AnyPublisher<T, Error>
    func asyncUpload<T: Decodable>(_ route: APIRoute, in environment: APIEnvironment, session: URLSession, decoder: JSONDecoder) async throws -> T
    func asyncDownload(fileURL: URL, session: URLSession) async throws -> URL
    func asyncDownload(_ route: APIRoute, in environment: APIEnvironment, session: URLSession) async throws -> URL
}

public extension APIClient {
    
    func asyncFetchRequest<T: Decodable>(_ route: APIRoute, in environment: APIEnvironment, session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) async throws -> T {
        let (data, response) = try await session.data(for: route.urlRequest(for: environment))
        return try self.manageResponse(data: data, response: response, decoder: decoder)
    }
    
    func combineFetchRequest<T: Decodable>(_ route: APIRoute, in environment: APIEnvironment, session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<T, Error> {
        do {
            return session
                .dataTaskPublisher(for: try route.urlRequest(for: environment))
                .tryMap { output in
                    return try self.manageResponse(data: output.data, response: output.response, decoder: decoder)
                }
                .eraseToAnyPublisher()
        } catch {
            return AnyPublisher<T, Error>(Fail(error: error))
        }
    }
    
    func asyncUpload<T: Decodable>(_ route: APIRoute, in environment: APIEnvironment, session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) async throws -> T {
        guard let uploadData = route.uploadData else {
            throw APIError.invalidUploadData
        }
        
        let (data, response) = try await session.upload(for: route.urlRequest(for: environment), from: uploadData)
        return try self.manageResponse(data: data, response: response, decoder: decoder)
    }
    
    func asyncDownload(fileURL: URL, session: URLSession = .shared) async throws -> URL {
        do {
            let response = try await session.download(from: fileURL)
            return response.0
        } catch {
            // you could also send analytics from here before throwing
            throw APIError.downloadError(error.localizedDescription)
        }
    }
    
    func asyncDownload(_ route: APIRoute, in environment: APIEnvironment, session: URLSession = .shared) async throws -> URL {
        do {
            let response = try await session.download(for: route.urlRequest(for: environment))
            return response.0
        } catch {
            throw APIError.downloadError(error.localizedDescription)
        }
    }
    
    private func manageResponse<T: Decodable>(data: Data, response: URLResponse, decoder: JSONDecoder) throws -> T {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidHTTPResponse
        }
        switch httpResponse.statusCode {
        case 200...299:
            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                throw APIError.decodingDataError
            }
        case 400...499:
            guard let decodedError = try? decoder.decode(ServerError.self, from: data) else {
                throw APIError.invalidHTTPResponse
            }
            
            if httpResponse.statusCode == 403 {
                NotificationCenter.default.post(name: .terminateSession, object: self)
            }
            throw APIError.serverError(decodedError.message)
        case 500...599:
            throw APIError.unknownError(code: httpResponse.statusCode, description: httpResponse.description)
        default:
            throw APIError.invalidHTTPResponse
        }
    }
}

extension Notification.Name {
    static let terminateSession = Notification.Name("terminateSession")
}
