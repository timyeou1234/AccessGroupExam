import Alamofire
import Foundation

final class APIClient {
    static let shared = APIClient()
    let headers: HTTPHeaders = [
        "Accept": "application/json",
    ]
}
