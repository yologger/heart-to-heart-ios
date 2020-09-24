import UIKit
import RxSwift
import RxCocoa

class HomeViewModel: BaseViewModel {
    
    let didCoordinatorChange = BehaviorSubject<HomeCoordinatorOptions>(value: .finishCreatePostVC)
    
    func createPost() {
        self.didCoordinatorChange.onNext(.startCreatePostVC)
    }
}
