import UIKit
import RxSwift
import RxCocoa

class FollowingViewModel: BaseViewModel {
    
    let didCoordinatorChange = PublishSubject<FollowCoordinatorOptions>()
    
}
