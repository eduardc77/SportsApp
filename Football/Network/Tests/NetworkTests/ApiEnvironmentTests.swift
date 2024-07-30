
import XCTest
@testable import Network

final class ApiEnvironmentTests: XCTestCase {

    func request(for route: TestRoute) -> URLRequest? {
        let env = TestEnvironment.production
        return try? env.urlRequest(for: route)
    }

    func testURLRequestIsCreatedWithRoute() throws {
        XCTAssertNotNil(request(for: .movie(id: "ABC123")))
        XCTAssertNotNil(request(for: .formLogin(userName: "johnappleseed", password: "super-secret")))
        XCTAssertNotNil(request(for: .postLogin(userName: "johnappleseed", password: "super-secret")))
        XCTAssertNotNil(request(for: .search(query: "A nice movie", page: 1)))
    }
}
