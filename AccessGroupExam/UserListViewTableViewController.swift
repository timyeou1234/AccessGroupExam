import UIKit
import Alamofire
import Kingfisher

class UserListViewTableViewController: UITableViewController {
    static let UserListTableViewCellIdentifier = "UserListTableViewCellIdentifier"
    static let LoadingStateTableViewCellIdentifier = "LoadingStateTableViewCellIdentifier"
    var users: [User] = []
    var loadingState: LoadingStatus = .idle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "UserListTableViewCell", bundle: nil), forCellReuseIdentifier: UserListViewTableViewController.UserListTableViewCellIdentifier)
        tableView.register(UINib(nibName: "LoadingStateTableViewCell", bundle: nil), forCellReuseIdentifier: UserListViewTableViewController.LoadingStateTableViewCellIdentifier)
        // Do any additional setup after loading the view.
        Task {
            await fetchUserListFromGitHub(nil)
        }
    }
    
    func fetchUserListFromGitHub(_ userId: Int?, perPage: Int = 20) async {
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer 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",
            "X-GitHub-Api-Version": "2022-11-28",
        ]

        // Automatic String to URL conversion, Swift concurrency support, and automatic retry.
        let response = await AF.request("https://api.github.com/users", parameters: [
            "since": userId ?? 0,
            "per_page": perPage
        ], headers: headers, interceptor: .retryPolicy)
        // Automatic Decodable support with background parsing.
            .serializingDecodable([User].self)
        // Await the full response with metrics and a parsed body.
            .response
    
        debugPrint(response)
        switch response.result {
        case .success(let users):
            self.users += users
            if users.count == perPage {
                loadingState = .hasMore
            } else {
                loadingState = .noMore
            }
        case .failure(let error):
            loadingState = .error(error: error)
        }
        await MainActor.run {
            self.tableView.reloadData()
        }
    }
}


extension UserListViewTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return users.count
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
            let user = users[indexPath.row]
            cell.nameLabel.text = user.login
            cell.avatarImageView.kf.setImage(with: user.avatar_url)
            cell.badgeContainerView.isHidden = !user.site_admin
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UserListViewTableViewController.LoadingStateTableViewCellIdentifier, for: indexPath) as? LoadingStateTableViewCell 
            else {
                return UITableViewCell()
            }
            cell.setLoadingStaus(loadingState)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && indexPath.row == 0 && loadingState == .hasMore {
            Task {
                await fetchUserListFromGitHub(users.last?.id)
            }
        }
    }
}
