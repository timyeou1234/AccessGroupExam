import UIKit
import Alamofire
import Kingfisher

class UserListViewTableViewController: UITableViewController {
    static let UserListTableViewCellIdentifier = "UserListTableViewCellIdentifier"
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "UserListTableViewCell", bundle: nil), forCellReuseIdentifier: UserListViewTableViewController.UserListTableViewCellIdentifier)
        // Do any additional setup after loading the view.
        Task {
            await fetchUserListFromGitHub()
            tableView.reloadData()
        }
    }
    
    func fetchUserListFromGitHub() async {
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer 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",
            "X-GitHub-Api-Version": "2022-11-28",
        ]

        // Automatic String to URL conversion, Swift concurrency support, and automatic retry.
        let response = await AF.request("https://api.github.com/users", headers: headers, interceptor: .retryPolicy)
        // Automatic Decodable support with background parsing.
            .serializingDecodable([User].self)
        // Await the full response with metrics and a parsed body.
            .response
    
        switch response.result {
        case .success(let users):
            self.users = users
        case .failure:
            return
        }
    }
}


extension UserListViewTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserListViewTableViewController.UserListTableViewCellIdentifier, for: indexPath) as? UserListTableViewCell
        else {
            return UITableViewCell()
        }
        let user = users[indexPath.row]
        cell.nameLabel.text = user.login
        cell.avatarImageView.kf.setImage(with: user.avatar_url)
        cell.badgeContainerView.isHidden = !user.site_admin
        return cell
    }
}
