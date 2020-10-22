import RxSwift

final class SignUpUseCase {
    
    var email: String?
    var firstname: String?
    var lastname: String?
    var nickname: String?
    var password: String?
    
    private let sessionRepository: SessionRepository
    
    init(sessionRepository: SessionRepository) {
        self.sessionRepository = sessionRepository
    }
}


extension SignUpUseCase: BaseUseCase {
    
    func executeTest() -> Observable<Bool> {
        return Observable<Bool>.create { observer -> Disposable in
            observer.onNext(true)
            return Disposables.create()
        }
    }
    
    func execute() {
        self.signUp()
    }
    
    private func signUp() {
        guard let email = self.email,
            let firstname = self.firstname,
            let lastname =  self.lastname,
            let nickname = self.nickname,
            let password = self.password else { return }
        
        sessionRepository.signUp(email: email, firstname: firstname, lastname: lastname, nickname: nickname, password: password)
    }
}
