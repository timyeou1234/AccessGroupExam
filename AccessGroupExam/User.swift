import Foundation

struct User: Codable {
    let login: String
    let id: Int
    let avatar_url: URL
    let site_admin: Bool
}
