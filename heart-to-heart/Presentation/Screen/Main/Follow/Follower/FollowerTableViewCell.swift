import UIKit

class FollowerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageViewAvatar: UIImageView!
    @IBOutlet weak var labelNickname: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        imageViewAvatar.layer.cornerRadius = 20
        imageViewAvatar.clipsToBounds = true
        
        let separatorLineHeight: CGFloat = 1/UIScreen.main.scale
        let separator = UIView()
        separator.frame = CGRect(x: self.frame.origin.x,
                                 y: self.frame.size.height - separatorLineHeight,
                                 width: self.frame.size.width,
                                 height: separatorLineHeight)
        separator.backgroundColor = AppColor.Grey.light
        self.addSubview(separator)
    }
}
