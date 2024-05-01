import UIKit

class UserListTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.shadowColor = UIColor.black.cgColor
            containerView.layer.shadowOffset = CGSize(width: 2, height: 2)
            containerView.layer.shadowRadius = 3
            containerView.layer.shadowOpacity = 0.9
        }
    }
    
    @IBOutlet weak var avatarImageView: UIImageView! {
        didSet {
            avatarImageView.layer.cornerRadius = 20
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var badgeContainerView: UIView! {
        didSet {
            badgeContainerView.layer.cornerRadius = 12.5
        }
    }
    @IBOutlet weak var badgeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
