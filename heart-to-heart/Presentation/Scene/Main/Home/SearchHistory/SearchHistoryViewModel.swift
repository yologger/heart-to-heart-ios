import UIKit
import RxSwift
import RxCocoa

class SearchHistoryViewModel: BaseViewModel {
    
    let didCoordinatorChange = BehaviorSubject<HomeCoordinatorOptions>(value: .showCreatePostVC)
    
}
