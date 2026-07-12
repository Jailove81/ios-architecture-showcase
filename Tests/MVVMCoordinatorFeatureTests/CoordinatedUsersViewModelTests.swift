import XCTest
@testable import MVVMCoordinatorFeature
import Domain

@MainActor
final class CoordinatedUsersViewModelTests: XCTestCase {
    final class SpyCoordinator: UsersFlowCoordinator {
        var shown: [User] = []
        func showDetail(for user: User) { shown.append(user) }
    }

    func testSelectDelegatesToCoordinator() async {
        let spy = SpyCoordinator()
        let sut = CoordinatedUsersViewModel(provider: StubUsersProvider(), coordinator: spy)
        await sut.load()

        sut.select(User(id: 1, name: "Ada Lovelace"))

        XCTAssertEqual(spy.shown.map(\.name), ["Ada Lovelace"])
    }
}
