import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var contextTextViewHeight: NSLayoutConstraint!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}
