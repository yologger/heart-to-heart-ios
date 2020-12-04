import UIKit
import RxSwift
import RxCocoa

class ProfileViewModel: BaseViewModel {
    
    let didCoordinatorChange = PublishSubject<ProfileCoordinatorOptions>()
    
    private let logOutUseCase: LogOutUseCase
    
    init(logOutUseCase: LogOutUseCase) {
        self.logOutUseCase = logOutUseCase
    }
    
    func changeNickname() {
        didCoordinatorChange.onNext(.showChangeNicknameVC)
    }
    
    func changePassword() {
        didCoordinatorChange.onNext(.showGetCurrentPasswordVC)
    }
    
    func logout() {
        logOutUseCase.execute()
            .subscribe(onNext: { logOutResult in
                switch logOutResult {
                case .success:
                    print("success")
                case .failure(let error):
                    switch error {
                    case .InvalidAccessToken:
                        print("InvalidAccessToken")
                    default:
                        print("Unknown Error")
                    }
                }
            }, onError: { error in
                
            }, onCompleted: {
                
            }, onDisposed: {
                
            }).disposed(by: self.disposeBag)
    }
}
