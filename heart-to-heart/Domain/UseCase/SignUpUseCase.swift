import RxSwift

class SignUpUseCase {
    
    var email: String?
    var firstName: String?
    var lastName: String?
    var nickname: String?
    var password: String?
    
    private let sessionRepository: SessionRepository
    
    init(sessionRepository: SessionRepository) {
        self.sessionRepository = sessionRepository
    }
    
    func execute() -> Observable<SignUpResponse> {
        return self.signUp()
    }
    
    private func signUp() -> Observable<SignUpResponse> {
        guard let email = self.email,
            let firstName = self.firstName,
            let lastName =  self.lastName,
            let nickname = self.nickname,
            let password = self.password else { return Observable<SignUpResponse>.create{ observer in
                return Disposables.create()
                } }
        
        return sessionRepository.signUp(email: email, firstName: firstName, lastName: lastName, nickname: nickname, password: password)
    }
}
