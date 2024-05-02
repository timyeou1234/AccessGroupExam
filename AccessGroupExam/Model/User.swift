import Foundation

struct User: Codable {
    /// This serve as user name as well
    let login: String
    let id: Int
    let avatar_url: URL
    let site_admin: Bool
}
