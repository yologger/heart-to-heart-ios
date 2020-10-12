import UIKit
import RxSwift
import RxCocoa

class FollowerViewController: UITableViewController, StoryboardInstantiable {
    static var storyboard: AppStoryboard = .follower
    
    private let disposeBase = DisposeBag()
    var viewModel: FollowerViewModel?
}
