import RxSwift

final class SignUpUseCase {
    
    var email: String?
    var fullname: String?
    var nickname: String?
    var password: String?
    
    private let sessionRepository: SessionRepository
    
    init(sessionRepository: SessionRepository) {
        self.sessionRepository = sessionRepository
    }
}


extension SignUpUseCase: BaseUseCase {
    
    func execute() {
        print("execute() from SignUpUseCase")
        self.signUp()
    }
    
    private func signUp() {
        guard let email = self.email, let fullname = self.fullname, let nickname = self.nickname, let password = self.password else {
            print("email, password are null")
            return }
        sessionRepository.signUp(email: email, fullname: fullname, nickname: nickname, password: password)
    }
}
