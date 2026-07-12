import XCTest
@testable import ReduxFeature
import Domain

@MainActor
final class UsersStoreTests: XCTestCase {
    func testQueryChangedUpdatesState() {
        let sut = UsersStore(environment: .init(provider: StubUsersProvider()))
        sut.send(.queryChanged("grace"))
        XCTAssertEqual(sut.state.query, "grace")
    }

    func testUsersLoadedStopsLoadingAndStores() {
        var initial = UsersState()
        initial.isLoading = true
        let sut = UsersStore(state: initial, environment: .init(provider: StubUsersProvider()))

        sut.send(.usersLoaded(User.sample))

        XCTAssertFalse(sut.state.isLoading)
        XCTAssertEqual(sut.state.users, User.sample)
    }

    func testVisibleUsersFilters() {
        var state = UsersState()
        state.users = User.sample
        state.query = "turing"
        XCTAssertEqual(state.visibleUsers.map(\.name), ["Alan Turing"])
    }
}
