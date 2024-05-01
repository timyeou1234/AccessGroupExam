import Foundation

/// This enum represents the loading status of a table view
enum TableViewLoadingStatus {
    case idle
    case hasMore
    case noMore
    case error(error: Error)
}

extension TableViewLoadingStatus: Equatable {
    static func == (lhs: TableViewLoadingStatus, rhs: TableViewLoadingStatus) -> Bool {
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
