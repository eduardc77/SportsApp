
import XCTest
@testable import Network

final class ApiRequestDataTests: XCTestCase {

    func testQueryItemsAreSortedAndEncoded() throws {
        let route = TestRoute.search(query: "let's search for &", page: 1)
        let items = route.encodedQueryItems
        XCTAssertEqual(items?.count, 2)
        XCTAssertEqual(items?[0].name, "p")
        XCTAssertEqual(items?[0].value, "1")
        XCTAssertEqual(items?[1].name, "q")
        XCTAssertEqual(items?[1].value, "let's search for &")
    }

    func testArrayQueryParametersAreJoined() throws {
        let route = TestRoute.searchWithArrayParams(years: [2021, 2022, 2023])
        let items = route.encodedQueryItems
        XCTAssertEqual(items?.count, 1)
        XCTAssertEqual(items?[0].name, "years")
        XCTAssertEqual(items?[0].value, "[2021,2022,2023]")
    }
}
