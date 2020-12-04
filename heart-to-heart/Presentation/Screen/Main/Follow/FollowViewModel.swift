import UIKit
import RxCocoa
import RxSwift

class FollowViewModel: BaseViewModel {
    
    let didCoordinatorChange = PublishSubject<FollowCoordinatorOptions>()
    
    func showFollowing() {
        didCoordinatorChange.onNext(.showFollowing)
    }
    
    func showFollower() {
        didCoordinatorChange.onNext(.showFollower)
    }
}
