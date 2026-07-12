import Foundation
import Combine
import Domain

/// A minimal unidirectional store: state is mutated only inside `send`.
@MainActor
public final class UsersStore: ObservableObject {
    @Published public private(set) var state: UsersState
    private let environment: UsersEnvironment

    public init(state: UsersState = .init(), environment: UsersEnvironment) {
        self.state = state
        self.environment = environment
    }

    public func send(_ action: UsersAction) {
        switch action {
        case .onAppear:
            state.isLoading = true
            Task { await load() }
        case let .queryChanged(query):
            state.query = query
        case let .usersLoaded(users):
            state.isLoading = false
            state.users = users
        case let .loadFailed(message):
            state.isLoading = false
            state.errorMessage = message
        }
    }

    private func load() async {
        do {
            send(.usersLoaded(try await environment.provider.fetchUsers()))
        } catch {
            send(.loadFailed(error.localizedDescription))
        }
    }
}
