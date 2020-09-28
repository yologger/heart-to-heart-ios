import UIKit
import RxSwift
import RxCocoa

class CreatePostViewModel: BaseViewModel {
    
    let didCoordinatorChange = BehaviorSubject<HomeCoordinatorOptions>(value: .showCreatePostVC)
}
