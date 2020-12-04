import UIKit
import RxSwift
import RxCocoa

class ChangePasswordViewModel: BaseViewModel {
    
    let didCoordinatorChange = PublishSubject<ProfileCoordinatorOptions>()
    
    func changePassword() {
        didCoordinatorChange.onNext(.closeChangePasswordVC)
    }
}
