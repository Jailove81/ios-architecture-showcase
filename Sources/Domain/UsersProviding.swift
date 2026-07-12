import Foundation

/// The single shared dependency every architecture in this repo consumes.
public protocol UsersProviding: Sendable {
    func fetchUsers() async throws -> [User]
}

public struct StubUsersProvider: UsersProviding {
    private let users: [User]

    public init(users: [User] = User.sample) {
        self.users = users
    }

    public func fetchUsers() async throws -> [User] {
        users
    }
}
