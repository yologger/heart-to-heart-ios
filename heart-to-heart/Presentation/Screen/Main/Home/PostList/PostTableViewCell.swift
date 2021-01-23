import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageViewAvatar: UIImageView!
    @IBOutlet weak var labelNickname: UILabel!
    @IBOutlet weak var labelCreatedAt: UILabel!
    @IBOutlet weak var labelContent: UILabel!
    
    @IBOutlet weak var labelLike: UILabel!
    @IBOutlet weak var viewDivider: UIView!
    @IBOutlet weak var viewPostDivider: UIView!
    
    override class func awakeFromNib() {
    }
    
    override func layoutSubviews() {
        imageViewAvatar.layer.cornerRadius = 20
        imageViewAvatar.clipsToBounds = true
        labelContent.lineBreakMode = .byCharWrapping
        labelContent.numberOfLines = 0
        viewDivider.backgroundColor = AppColor.Grey.light
        viewPostDivider.backgroundColor = AppColor.Grey.dark
    }
}
