import UIKit
import RxSwift
import RxCocoa

class ProfileViewModel: BaseViewModel {
    
    let didCoordinatorChange = BehaviorSubject<ProfileCoordinatorOptions>(value: .showChangePasswordVC)
    
    func logOut() {
        print("logOut() from ProfileViewModel")
    }
}
