import UIKit

class ImageItemWithClearButton: UICollectionViewCell {
    
    @IBOutlet weak var imageViewAvatar: UIImageView!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        imageViewAvatar.layer.cornerRadius = 16
        super.layoutSubviews()
    }
    
}
