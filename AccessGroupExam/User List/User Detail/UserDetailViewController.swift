import Combine
import Kingfisher
import UIKit

class UserDetailViewController: UIViewController {
    @IBOutlet weak var avatarImageView: UIImageView! {
        didSet {
            avatarImageView.layer.cornerRadius = 60
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var staffBadgeView: UIView! {
        didSet {
            staffBadgeView.layer.cornerRadius = 7.5
        }
    }
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var linkTextView: UITextView!
    
    private let viewModel: UserDetailViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(userName: String, apiClient: APIClient) {
        self.viewModel = UserDetailViewModel(userName: userName, apiClient: apiClient)
        super.init(nibName: String(describing: UserDetailViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        viewModel.getUserDetail()
    }
    
    private func bindViewModel() {
        viewModel.$userDetail
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] userDetail in
                guard let self else { return }
                self.avatarImageView.kf.setImage(with: userDetail.avatar_url)
                self.nameLabel.text = userDetail.login
                self.staffBadgeView.isHidden = !userDetail.site_admin
                self.locationLabel.text = userDetail.location
                self.linkTextView.text = userDetail.url.absoluteString
            }
            .store(in: &cancellables)
        
        viewModel.$loadingStatus
            .receive(on: DispatchQueue.main)
            .sink { status in
                switch status {
                case .error(let error):
                    let alertController = UIAlertController(title: "Oops!", message: error.localizedDescription, preferredStyle: .alert)
                    let dismissAction = UIAlertAction(title: "Go back", style: .default) { _ in
                        self.dismiss(animated: true)
                    }
                    alertController.addAction(dismissAction)
                    let retryAction = UIAlertAction(title: "Retry", style: .default)
                    alertController.addAction(retryAction)
                    self.present(alertController, animated: true)
                default:
                    break
                }
            }
            .store(in: &cancellables)
    }
}
