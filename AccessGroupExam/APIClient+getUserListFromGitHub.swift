import Alamofire
import Combine
import Foundation

extension APIClient {
    func getUserListFromGitHub(_ userId: Int?, perPage: Int = 20) -> AnyPublisher<[User], AFError> {
        return AF.request("https://api.github.com/users", parameters: [
            "since": userId ?? 0,
            "per_page": perPage
        ], headers: headers, interceptor: .retryPolicy)
        .validate()
        .publishDecodable(type: [User].self)
        .value()
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
