import Alamofire
import Combine
import Kingfisher
import UIKit

final class UserListViewTableViewController: UITableViewController {
    static let UserListTableViewCellIdentifier = "UserListTableViewCellIdentifier"
    static let LoadingStateTableViewCellIdentifier = "LoadingStateTableViewCellIdentifier"
    
    private var apiClient = APIClient.shared
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var viewModel = UserListViewModel(apiClient: apiClient)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "UserListTableViewCell", bundle: nil), forCellReuseIdentifier: UserListViewTableViewController.UserListTableViewCellIdentifier)
        tableView.register(UINib(nibName: "LoadingStateTableViewCell", bundle: nil), forCellReuseIdentifier: UserListViewTableViewController.LoadingStateTableViewCellIdentifier)
        bindViewModel()
        // Get the first page of the users
        viewModel.getUserListFromGitHub(nil)
    }
    
    private func bindViewModel() {
        Publishers.CombineLatest(viewModel.$status, viewModel.$users)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self else { return }
                self.tableView.reloadData()
            }.store(in: &cancellables)
    }
}


extension UserListViewTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return viewModel.users.count
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UserListViewTableViewController.UserListTableViewCellIdentifier, for: indexPath) as? UserListTableViewCell
            else {
                return UITableViewCell()
            }
            let user = viewModel.users[indexPath.row]
            cell.nameLabel.text = user.login
            cell.avatarImageView.kf.setImage(with: user.avatar_url)
            cell.badgeContainerView.isHidden = !user.site_admin
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UserListViewTableViewController.LoadingStateTableViewCellIdentifier, for: indexPath) as? LoadingStateTableViewCell 
            else {
                return UITableViewCell()
            }
            cell.setLoadingStatus(viewModel.status)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && indexPath.row == 0 && viewModel.status == .hasMore {
            viewModel.getUserListFromGitHub(viewModel.users.last?.id, perPage: 20)
        }
    }
}

extension UserListViewTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 0 else {
            return
        }
        let userName = viewModel.users[indexPath.row].login
        let userDetailViewController = UserDetailViewController(userName: userName, apiClient: apiClient)
        present(userDetailViewController, animated: true)
    }
}
