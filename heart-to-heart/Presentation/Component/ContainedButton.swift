import UIKit

@IBDesignable
class ContainedButton: UIButton {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    
    internal func setupUI() {
        self.backgroundColor = AppColor.Pink.normal
        self.layer.cornerRadius = 4
        self.setTitleColor(AppColor.White.normal, for: .normal)
        self.clipsToBounds = true
        self.contentEdgeInsets = UIEdgeInsets(top: 4.0, left: 8.0, bottom: 4.0, right: 8.0)
        self.titleEdgeInsets = UIEdgeInsets(top: 4.0, left: 8.0, bottom: 4.0, right: 8.0)
    }
}
