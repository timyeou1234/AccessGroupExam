import UIKit

class LoadingStateTableViewCell: UITableViewCell {

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingStatusLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setLoadingStatus(_ loadingStatus: TableViewLoadingStatus) {
        switch loadingStatus {
        case .idle:
            loadingIndicator.stopAnimating()
            loadingIndicator.isHidden = true
            loadingStatusLable.isHidden = true
        case .hasMore:
            loadingIndicator.startAnimating()
            loadingIndicator.isHidden = false
            loadingStatusLable.isHidden = true
        case .noMore:
            loadingIndicator.stopAnimating()
            loadingIndicator.isHidden = true
            loadingStatusLable.isHidden = false
            loadingStatusLable.text = "No more data"
        case .error(let error):
            loadingStatusLable.isHidden = false
            loadingIndicator.isHidden = true
            loadingStatusLable.text = error.localizedDescription
        }
    }
}
