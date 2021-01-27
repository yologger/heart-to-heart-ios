import UIKit
import RxSwift
import RxCocoa

class ProfileViewModel: BaseViewModel {
    
    let didCoordinatorChange = PublishSubject<ProfileCoordinatorOptions>()
    
    private let logOutUseCase: LogOutUseCase
    private let fetchCurrentUserInfomationUseCase: FetchCurrentUserInformationUseCase
    private let updateAvatarImageUseCase: UpdateAvatarImageUseCase
    
    var userSession: UserSession?
    
    var nicknameObservable = BehaviorSubject<String?>(value: nil)
    var emailObservable = BehaviorSubject<String?>(value: nil)
    var avatarObservable = BehaviorSubject<String?>(value: nil)
    
    init(logOutUseCase: LogOutUseCase, fetchCurrentUserInfomationnUseCase: FetchCurrentUserInformationUseCase, updateAvatarImageUseCase: UpdateAvatarImageUseCase ) {
        self.logOutUseCase = logOutUseCase
        self.fetchCurrentUserInfomationUseCase = fetchCurrentUserInfomationnUseCase
        self.updateAvatarImageUseCase = updateAvatarImageUseCase
    }
    
    func fetchCurrentUserInformation() {
        print("fetch")
        fetchCurrentUserInfomationUseCase.execute()
            .take(1)
            .subscribe { [weak self] result in
                switch result {
                case .success(let session):
                    self?.userSession = session
                    self?.nicknameObservable.onNext(session.profile.nickname)
                    self?.emailObservable.onNext(session.profile.email)
                    self?.avatarObservable.onNext(session.profile.url)
                case .failure:
                    print("fail")
                }
            } onError: { error in
                
            } onCompleted: {
                
            } onDisposed: {
                
            }.disposed(by: disposeBag)

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
    
    func updateAvatarImage(image: UIImage?) {
        updateAvatarImageUseCase.image = image
        updateAvatarImageUseCase.execute()
            .take(1)
            .subscribe(onNext: { [weak self] result in
                switch result {
                case .success(let data):
                    let url = data.url
                    self?.avatarObservable.onNext(url)
                case .failure:
                    print("failure  ")
                }
            }, onError: { error in
                
            }, onCompleted: {
                
            }, onDisposed: {
                
            }).disposed(by: self.disposeBag)
    }
}
