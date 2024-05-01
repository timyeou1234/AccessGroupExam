import Combine
import Foundation

final class UserDetailViewModel {
    enum LoadingStatus {
        case idle
        case success
        case error(error: Error)
    }
    
    @Published var userDetail: UserDetail?
    @Published var loadingStatus: LoadingStatus = .idle
    
    private let userName: String
    
    private var apiClient: APIClient
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(userName: String, apiClient: APIClient) {
        self.userName = userName
        self.apiClient = apiClient
    }
    
    func getUserDetail() {
        apiClient.getUserDetail(userName)
            .sink  { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .finished:
                    break
                case .failure(let afError):
                    self.loadingStatus = .error(error: afError)
                }
            } receiveValue: { [weak self] value in
                guard let self else { return }
                self.userDetail = value
            }
            .store(in: &cancellables)
    }
}
