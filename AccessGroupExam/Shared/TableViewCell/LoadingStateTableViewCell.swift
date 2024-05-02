import UIKit

/// This cell is for load more UI in table view with a nib file
final class LoadingStateTableViewCell: UITableViewCell {
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingStatusLabel: UILabel!
    
    func setLoadingStatus(_ loadingStatus: TableViewLoadingStatus) {
        switch loadingStatus {
        case .idle:
            loadingIndicator.stopAnimating()
            loadingIndicator.isHidden = true
            loadingStatusLabel.isHidden = true
        case .hasMore:
            loadingIndicator.startAnimating()
            loadingIndicator.isHidden = false
            loadingStatusLabel.isHidden = true
        case .noMore:
            loadingIndicator.stopAnimating()
            loadingIndicator.isHidden = true
            loadingStatusLabel.isHidden = false
            loadingStatusLabel.text = "No more data"
        case .error(let error):
            loadingStatusLabel.isHidden = false
            loadingIndicator.isHidden = true
            loadingStatusLabel.text = error.localizedDescription
        }
    }
}
