import UIKit

@IBDesignable
class TopTabBar: UISegmentedControl {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    internal func setupUI() {
        self.backgroundColor = AppColor.Blue.normal
        self.tintColor = AppColor.Orange.normal
    }
    
    func removeBorder(){
        
    }
}
