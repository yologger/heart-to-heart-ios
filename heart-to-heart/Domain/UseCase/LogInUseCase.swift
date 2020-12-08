import RxSwift

final class LogInUseCase {

    var email: String?
    var password: String?
    
    private let sessionRepository: SessionRepository
    
    init(sessionRepository: SessionRepository) {
        self.sessionRepository = sessionRepository
    }
        
    private func logIn() -> Observable<LogInResult> {
        return sessionRepository.logIn(email: self.email!, password: self.password!)
    }
}

extension LogInUseCase: BaseUseCase {
    func call() -> Observable<LogInResult> {
        self.logIn()
    }
}
