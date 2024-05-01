import Combine
import Foundation

final class UserListViewModel {
    @Published var users: [User] = []
    @Published var status: LoadingStatus = .idle
    
    private var apiClient: APIClient
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func getUserListFromGitHub(_ userId: Int?, perPage: Int = 20) {
        apiClient.getUserListFromGitHub(userId, perPage: perPage)
            .sink { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .finished:
                    break
                case .failure(let afError):
                    self.status = .error(error: afError)
                }
            } receiveValue: { [weak self] value in
                guard let self else { return }
                self.status = value.count == perPage ? .hasMore : .noMore
                if userId != nil {
                    self.users += value
                    if self.users.count >= 100 {
                        self.users = Array(self.users.prefix(100))
                        self.status = .noMore
                    }
                } else {
                    self.users = value
                }
            }.store(in: &cancellables)
    }
}
