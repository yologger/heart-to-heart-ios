import UIKit
import RxSwift
import RxCocoa

class FollowerViewModel: BaseViewModel {
    
    let didCoordinatorChange = PublishSubject<FollowCoordinatorOptions>()
    
}
