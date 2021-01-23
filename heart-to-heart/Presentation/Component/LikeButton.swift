import UIKit

@IBDesignable
class LikeButton: UIButton {
    
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
            drawLikeButton()
        } else {
            drawUnlikeButton()
        }
    }
    
    internal func drawLikeButton() {
        self.setTitle(nil, for: .normal)
        let btnImage = UIImage(named: "favorite_icon")
        self.setImage(btnImage, for: .normal)
    }
    
    internal func drawUnlikeButton() {
        self.setTitle(nil, for: .normal)
        let btnImage = UIImage(named: "favorite_border_black_icon")
        self.setImage(btnImage, for: .normal)
    }
    
    internal func setup() {
        self.addTarget(self, action: #selector(tapped), for: .touchUpInside)
    }
    
    private func updateUI() {
        if (checked) {
            drawLikeButton()
        } else {
            drawUnlikeButton()
        }
    }
    
    @objc private func tapped() {
        checked = !checked
        print("New value: \(checked)")
    }
}
