import UIKit
import RxSwift
import RxCocoa

class LogInViewModel: BaseViewModel {
    
    let didCoordinatorChange = PublishSubject<AuthorizationCoordinatorOptions>()
    
    let email = BehaviorSubject<String>(value: "")
    let password = BehaviorSubject<String>(value: "")
    let isEmailValid = BehaviorSubject<Bool>(value: false)
    let isPasswordValid = BehaviorSubject<Bool>(value: false)
    
    let didClickLogInButton = BehaviorSubject(value: false)
    let didClickSignUpButton = BehaviorSubject(value: false)
    let didClickFindPasswordButton = BehaviorSubject(value: false)
    
    private let logInUseCase: LogInUseCase
    
    init(logInUseCase: LogInUseCase) {
        self.logInUseCase = logInUseCase
        super.init()
        self.bindUI()
    }
    
    private func bindUI() {
        email.map(checkEmailValidation).bind(to: self.isEmailValid).disposed(by: self.disposeBag)
        password.map(checkPasswordValidation).bind(to: self.isPasswordValid).disposed(by: self.disposeBag)
    }
    
    private func checkEmailValidation(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func checkPasswordValidation(_ password: String?) -> Bool {
        guard password != nil else { return false }
        // at least one uppercase,
        // at least one digit
        // at least one lowercase
        // 8 characters total
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        return passwordPred.evaluate(with: password)
    }
    
    func logIn(email: String, password: String) {
        logInUseCase.email = email
        logInUseCase.password = password
        logInUseCase.execute()
            .subscribe(onNext: { logInResponse in
                print("subscribe() onNext()")
                switch logInResponse {
                case .success:
                    print("success")
                case .error(let error):
                    switch error {
                    case .wrongEmailError:
                        print("wrongEmailError")
                    case .wrongPasswordError:
                        print("wrongPasswordError")
                    case .internalServerError:
                        print("internalServerError")
                    case .networkError:
                        print("networkError")
                    case .unknownError:
                        print("unknownError")
                    }
                }
            }, onError: { error in
                print(error)
            }, onCompleted: {
                print("onCompleted")
            }) {
                print("onDisposed")
        }.disposed(by: self.disposeBag)
    }
    
    func signUp() {
        didCoordinatorChange.onNext(.showSignUpVC)
    }
    
    func findPassword() {
        self.logInUseCase.execute()
        didCoordinatorChange.onNext(.showFindPasswordVC)
    }
}
