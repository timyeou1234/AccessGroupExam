import Alamofire
import Combine
import Foundation

extension APIClient {
    func getUserDetail(_ userName: String) -> AnyPublisher<UserDetail, AFError> {
        return AF.request("https://api.github.com/users/\(userName)", headers: headers, interceptor: .retryPolicy)
        .validate()
        .publishDecodable(type: UserDetail.self)
        .value()
        .receive(on: DispatchQueue.main)
        .print()
        .eraseToAnyPublisher()
    }
}
