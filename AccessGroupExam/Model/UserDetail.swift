import Foundation

struct UserDetail: Codable {
    let id: Int
    /// This serve as user name as well
    let login: String
    let avatar_url: URL
    let url: URL
    let site_admin: Bool
    let location: String
}
