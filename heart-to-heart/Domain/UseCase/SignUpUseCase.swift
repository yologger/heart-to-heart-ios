import RxSwift

class SignUpUseCase {
    
    var email: String?
    var firstname: String?
    var lastname: String?
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
            let firstname = self.firstname,
            let lastname =  self.lastname,
            let nickname = self.nickname,
            let password = self.password else { return Observable<SignUpResponse>.create{ observer in
                return Disposables.create()
                } }
        
        return sessionRepository.signUp(email: email, firstname: firstname, lastname: lastname, nickname: nickname, password: password)
    }
}
