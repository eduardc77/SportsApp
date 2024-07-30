
import XCTest
@testable import Network

final class ApiClientTests: XCTestCase {
    
    private let route = TestRoute.movie(id: UUID().uuidString)
    private let env = TestEnvironment.production
    
    func client(withData data: Data = .init()) -> TestClient {
        TestClient(data: data)
    }
    
    struct TestModel: Codable {
        let id: Int
        let title: String
    }

    @MainActor 
    private func setMockProtocol(statusCode: Int = 200) {
        MockURLProtocol.requestHandler = { request in
            let expectedResponseData =
            """
            {"id": 1, "title": "Hello, world!"}
            """
            .data(using: .utf8)!
            let response = HTTPURLResponse.init(url: request.url!, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
            return (response, expectedResponseData)
        }
    }
    
    func testAsyncFetchRequestAtRouteSucceedsIfServiceReturnsValidData() async throws {
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: sessionConfiguration)
        await setMockProtocol()
        
        let route = MockApiRoute()

        do {
            let result: TestModel = try await client().asyncFetchRequest(route, in: env, session: session)
            XCTAssertEqual(result.id, 1)
            XCTAssertEqual(result.title, "Hello, world!")
        } catch {
            XCTFail("Should fail")
        }
    }
    
    func testAsyncFetchRequestAtRouteFailsForInvalidResponse() async throws {
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: sessionConfiguration)
        await setMockProtocol(statusCode: 100)
        
        let route = MockApiRoute()

        do {
            let result: TestModel = try await client().asyncFetchRequest(route, in: env, session: session)
            XCTAssertEqual(result.id, 1)
            XCTAssertEqual(result.title, "Hello, world!")
        } catch {
            let error = error as? APIError
            XCTAssertTrue(error?.isInvalidResponseStatusCode == true)
        }
    }

    func testFetchingItemAtRouteFailsIfServiceThrowsError() async {
        do {
            let _: TestMovie? = try await client().asyncFetchRequest(route, in: env)
            XCTFail("Should fail")
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    func testFetchingItemAtRouteFailsForInvalidData() async throws {
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: sessionConfiguration)
        await setMockProtocol()
        
        do {
            let _: String? = try await client().asyncFetchRequest(route, in: env, session: session)
            XCTFail("Should fail")
        } catch {
            let error = error as? APIError
            XCTAssertTrue(error?.isDecodingDataError == true)
        }
    }
}
