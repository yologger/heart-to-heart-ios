import UIKit
import RxSwift
import RxCocoa

class LogInViewModel: BaseViewModel {
    
    let email = BehaviorSubject<String>(value: "")
    let password = BehaviorSubject<String>(value: "")
    let isEmailValid = BehaviorSubject<Bool>(value: false)
    let isPasswordValid = BehaviorSubject<Bool>(value: false)
    
    let didClickLogInButton = BehaviorSubject(value: false)
    let didClickSignUpButton = BehaviorSubject(value: false)
    let didClickFindPasswordButton = BehaviorSubject(value: false)
    
    let logInUseCase = LogInUseCase()
    
    override init() {
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
    
    func logIn() {
        self.didClickLogInButton.onNext(true)
//        self.logInUseCase.execute()
//        .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
//        .observeOn(MainScheduler.instance)
//            .subscribe(
//            onNext: { [weak self] isSuccess in
//                print("onNext!")
//                self?.didClickLogInButton.onNext(true)
//            }, onError: { (Error) in
//            }, onCompleted: {
//            }, onDisposed: {
//            }).disposed(by: disposeBag)
    }
    
    func signUp() {
        didClickSignUpButton.onNext(true)
    }
    
    func findPassword() {
        didClickFindPasswordButton.onNext(true)
    }
}
