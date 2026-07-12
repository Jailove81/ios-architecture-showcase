import Foundation
import Observation
import Domain

/// Navigation intent is expressed through a coordinator, not performed by the view model.
@MainActor
public protocol UsersFlowCoordinator: AnyObject {
    func showDetail(for user: User)
}

@Observable
@MainActor
public final class CoordinatedUsersViewModel {
    private let provider: UsersProviding
    private weak var coordinator: UsersFlowCoordinator?

    public private(set) var users: [User] = []

    public init(provider: UsersProviding, coordinator: UsersFlowCoordinator) {
        self.provider = provider
        self.coordinator = coordinator
    }

    public func load() async {
        users = (try? await provider.fetchUsers()) ?? []
    }

    /// Delegates navigation, keeping this type free of any UIKit/SwiftUI navigation code.
    public func select(_ user: User) {
        coordinator?.showDetail(for: user)
    }
}
