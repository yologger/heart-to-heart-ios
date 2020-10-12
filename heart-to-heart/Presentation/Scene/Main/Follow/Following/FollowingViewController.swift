import UIKit
import RxSwift
import RxCocoa

class FollowingViewController: UITableViewController, StoryboardInstantiable {
    
    static var storyboard: AppStoryboard = .following
    
    var num = 4
    
    override func viewDidLoad() {
        print("viewDidLoad() from FollowingViewController")
    }
}
