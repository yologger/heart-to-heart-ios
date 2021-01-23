import UIKit
import SnapKit

class TestViewController: BaseViewController, StoryboardInstantiable {
    
    static var storyboard = AppStoryboard.test
    
    @IBOutlet weak var followButton: FollowButton!
    
    lazy var testButton: UIButton = {
        let button = UIButton()
        button.setTitle("TestButton", for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        followButton.checked = false
        followButton.addTarget(self, action: #selector(onButtonClick), for: .touchUpInside)
    }
    
    @objc func onButtonClick(_ sender: FollowButton) {
        print("Button was tapped.: \(sender.checked)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //        self.view.addSubview(testButton)
        //        testButton.snp.makeConstraints { make in
        //            make.top.equalToSuperview()
        //            make.bottom.equalToSuperview()
        //            make.leading.equalToSuperview()
        //            make.trailing.equalToSuperview()
        //        }
        
        super.viewWillAppear(animated)
    }
}
