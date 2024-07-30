
import XCTest
@testable import Network

final class HttpMethodTests: XCTestCase {

    func method(for method: HTTPMethod) -> String {
        method.method
    }

    func testMethodIsUppercasedForAllCases() throws {
        HTTPMethod.allCases.forEach { method in
            XCTAssertEqual(method.method, method.rawValue.uppercased())
        }
    }

    func testMethodIsUppercased() throws {
        XCTAssertEqual(method(for: .connect), "CONNECT")
        XCTAssertEqual(method(for: .delete), "DELETE")
        XCTAssertEqual(method(for: .get), "GET")
        XCTAssertEqual(method(for: .head), "HEAD")
        XCTAssertEqual(method(for: .options), "OPTIONS")
        XCTAssertEqual(method(for: .post), "POST")
        XCTAssertEqual(method(for: .put), "PUT")
        XCTAssertEqual(method(for: .trace), "TRACE")
    }

    func testMethodUsesRawNameAsId() throws {
        HTTPMethod.allCases.forEach { method in
            XCTAssertEqual(method.id, method.rawValue)
        }
    }
}
