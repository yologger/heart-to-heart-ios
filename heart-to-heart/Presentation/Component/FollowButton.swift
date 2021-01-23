import UIKit

@IBDesignable
class FollowButton: UIButton {
    
    @IBInspectable var checked: Bool = false {
        didSet {
            updateUI()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupUI()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
        setupUI()
    }
    
    internal func setupUI() {
        if (checked) {
            drawFollowingButton()
        } else {
            drawFollowButton()
        }
    }
    
    internal func drawFollowButton() {
        self.backgroundColor = AppColor.Primary.normal
        self.layer.borderColor = AppColor.Primary.normal.cgColor
        self.setTitleColor(AppColor.White.normal, for: .normal)
        self.layer.cornerRadius = 3
        self.layer.borderWidth = 2
        self.contentEdgeInsets = UIEdgeInsets(top: 4.0, left: 8.0, bottom: 4.0, right: 8.0)
        self.setTitle("Follow", for: .normal)
    }
    
    internal func drawFollowingButton() {
        self.backgroundColor = AppColor.White.normal
        self.layer.borderColor = AppColor.Grey.light.cgColor
        self.setTitleColor(AppColor.Black.normal, for: .normal)
        self.layer.cornerRadius = 3
        self.layer.borderWidth = 2
        self.contentEdgeInsets = UIEdgeInsets(top: 4.0, left: 8.0, bottom: 4.0, right: 8.0)
        self.setTitle("Following", for: .normal)
    }
    
    internal func setup() {
        self.addTarget(self, action: #selector(tapped), for: .touchUpInside)
    }
    
    private func updateUI() {
        if (checked) {
            drawFollowingButton()
        } else {
            drawFollowButton()
        }
    }
    
    @objc private func tapped() {
        checked = !checked
        print("New value: \(checked)")
    }
}
