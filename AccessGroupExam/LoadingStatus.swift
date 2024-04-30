import Foundation

enum LoadingStatus {
    case idle
    case hasMore
    case noMore
    case error(error: Error)
}

extension LoadingStatus: Equatable {
    static func == (lhs: LoadingStatus, rhs: LoadingStatus) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle):
            return true
        case (.hasMore, .hasMore):
            return true
        case (.noMore, .noMore):
            return true
        case (.error, .error):
            return true
        default:
            return false
        }
    }
}
