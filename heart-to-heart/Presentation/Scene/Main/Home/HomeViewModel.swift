import UIKit
import RxSwift
import RxCocoa

class HomeViewModel: BaseViewModel {
    
    let didCoordinatorChange = BehaviorSubject<HomeCoordinatorOptions>(value: .showCreatePostVC)
    
    func createPost() {
        self.didCoordinatorChange.onNext(.showCreatePostVC)
    }
    
    func showSearchHistory() {
        self.didCoordinatorChange.onNext(.showSearchHistoryVC)
    }
    
    func closeSearchHistory() {
        self.didCoordinatorChange.onNext(.closeSearchHistoryVC)
    }
}
