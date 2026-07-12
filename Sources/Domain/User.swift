import Foundation

public struct User: Identifiable, Equatable, Sendable {
    public let id: Int
    public let name: String

    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

public extension User {
    static let sample: [User] = [
        User(id: 1, name: "Ada Lovelace"),
        User(id: 2, name: "Alan Turing"),
        User(id: 3, name: "Grace Hopper"),
        User(id: 4, name: "Edsger Dijkstra")
    ]
}
