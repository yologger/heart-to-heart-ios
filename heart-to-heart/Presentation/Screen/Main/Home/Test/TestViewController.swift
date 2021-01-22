import UIKit
import SnapKit

class TestViewController: BaseViewController, StoryboardInstantiable {
    
    static var storyboard = AppStoryboard.test
    
    lazy var testButton: UIButton = {
        let button = UIButton()
        button.setTitle("TestButton", for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.addSubview(testButton)
        testButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        super.viewWillAppear(animated)
    }
}
