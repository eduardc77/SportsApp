
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
        TestURLProtocol.requestHandler = { request in
            let expectedResponseData =
            """
            {"id": 1, "title": "Hello, world!"}
            """
            .data(using: .utf8)!
            let response = HTTPURLResponse.init(url: request.url!, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
            return (response, expectedResponseData)
        }
    }
    
    private var testURLSession: URLSession {
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [TestURLProtocol.self]
        return URLSession(configuration: sessionConfiguration)
    }
    
    func testAsyncFetchRequestAtRouteSucceedsIfServiceReturnsValidData() async throws {
        await setMockProtocol()
        
        let route = MockApiRoute()

        do {
            let result: TestModel = try await client().asyncFetchRequest(route, in: env, session: testURLSession)
            XCTAssertEqual(result.id, 1)
            XCTAssertEqual(result.title, "Hello, world!")
        } catch {
            XCTFail("Should fail")
        }
    }
    
    func testAsyncFetchRequestAtRouteFailsForInvalidResponse() async throws {
        await setMockProtocol(statusCode: 100)
        
        let route = MockApiRoute()

        do {
            let result: TestModel = try await client().asyncFetchRequest(route, in: env, session: testURLSession)
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

        await setMockProtocol()
        
        do {
            let _: String? = try await client().asyncFetchRequest(route, in: env, session: testURLSession)
            XCTFail("Should fail")
        } catch {
            let error = error as? APIError
            XCTAssertTrue(error?.isDecodingDataError == true)
        }
    }
}
