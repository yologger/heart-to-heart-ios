import UIKit
import RxSwift
import RxCocoa

class GetCurrentPasswordViewModel: BaseViewModel {
    
    let password = BehaviorSubject<String>(value: "")
    
    let didCoordinatorChange = PublishSubject<ProfileCoordinatorOptions>()
    
    func checkCurrentPassword() {
        didCoordinatorChange.onNext(.showChangePasswordVC)
    }
}
