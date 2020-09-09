import UIKit
import RxSwift

class FindPasswordViewController: UIViewController, StoryboardInstantiable {
    static var storyboard = AppStoryboard.findPassword
    
    private let disposeBag = DisposeBag()
    var viewModel: FindPasswordViewModel?
}
