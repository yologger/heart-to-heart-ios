import UIKit
import RxSwift
import RxCocoa

class ProfileViewModel: BaseViewModel {
    
    let didCoordinatorChange = PublishSubject<ProfileCoordinatorOptions>()
    
    func changeNickname() {
        didCoordinatorChange.onNext(.showChangeNicknameVC)
    }
    
    func changePassword() {
        didCoordinatorChange.onNext(.showGetCurrentPasswordVC)
    }
    
    func logout() {
        print("logout() from ProfileViewModel")
    }
}
