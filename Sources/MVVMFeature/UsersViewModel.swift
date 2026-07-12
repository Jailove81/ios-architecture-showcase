import Foundation
import Observation
import Domain

@Observable
@MainActor
public final class UsersViewModel {
    public enum State: Equatable {
        case idle
        case loading
        case loaded([User])
        case failed(String)
    }

    private let provider: UsersProviding
    public private(set) var state: State = .idle
    public var query: String = ""

    public init(provider: UsersProviding) {
        self.provider = provider
    }

    /// Derived, not stored — the single source of truth is `state` + `query`.
    public var visibleUsers: [User] {
        guard case let .loaded(users) = state else { return [] }
        guard !query.isEmpty else { return users }
        return users.filter { $0.name.localizedCaseInsensitiveContains(query) }
    }

    public func load() async {
        state = .loading
        do {
            state = .loaded(try await provider.fetchUsers())
        } catch {
            state = .failed(error.localizedDescription)
        }
    }
}
