import SwiftUI
import Domain

public struct UsersView: View {
    @State private var viewModel: UsersViewModel

    public init(viewModel: UsersViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    public var body: some View {
        List(viewModel.visibleUsers) { user in
            Text(user.name)
        }
        .searchable(text: $viewModel.query)
        .task { await viewModel.load() }
    }
}
