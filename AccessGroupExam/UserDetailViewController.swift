//
//  UserDetailViewController.swift
//  AccessGroupExam
//
//  Created by Tim on 2024/5/1.
//

import UIKit

class UserDetailViewController: UIViewController {
    let userId: Int
    
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
    
    init(userId: Int) {
        self.userId = userId
        super.init(nibName: String(describing: UserDetailViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
