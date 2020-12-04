import UIKit
import RxSwift
import RxCocoa

class ChangeNicknameViewModel: BaseViewModel {
    
    let didCoordinatorChange = PublishSubject<ProfileCoordinatorOptions>()
    
    func changeNickname() {
        didCoordinatorChange.onNext(.closeChangeNicknameVC)
    }
}
