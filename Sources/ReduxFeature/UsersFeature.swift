import Foundation
import Domain

public struct UsersState: Equatable {
    public var query: String = ""
    public var users: [User] = []
    public var isLoading: Bool = false
    public var errorMessage: String?

    public init() {}

    public var visibleUsers: [User] {
        guard !query.isEmpty else { return users }
        return users.filter { $0.name.localizedCaseInsensitiveContains(query) }
    }
}

public enum UsersAction: Equatable {
    case onAppear
    case queryChanged(String)
    case usersLoaded([User])
    case loadFailed(String)
}

public struct UsersEnvironment: Sendable {
    public var provider: UsersProviding
    public init(provider: UsersProviding) {
        self.provider = provider
    }
}
