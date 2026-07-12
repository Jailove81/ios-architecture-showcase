import XCTest
@testable import MVVMFeature
import Domain

@MainActor
final class UsersViewModelTests: XCTestCase {
    func testLoadTransitionsToLoaded() async {
        let sut = UsersViewModel(provider: StubUsersProvider(users: User.sample))
        await sut.load()
        XCTAssertEqual(sut.state, .loaded(User.sample))
    }

    func testQueryFiltersCaseInsensitively() async {
        let sut = UsersViewModel(provider: StubUsersProvider(users: User.sample))
        await sut.load()
        sut.query = "ada"
        XCTAssertEqual(sut.visibleUsers.map(\.name), ["Ada Lovelace"])
    }

    func testFailureProducesFailedState() async {
        struct FailingProvider: UsersProviding {
            func fetchUsers() async throws -> [User] { throw NSError(domain: "test", code: 1) }
        }
        let sut = UsersViewModel(provider: FailingProvider())
        await sut.load()
        guard case .failed = sut.state else {
            return XCTFail("Expected failed state")
        }
    }
}
