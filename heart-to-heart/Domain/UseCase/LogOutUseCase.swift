import RxSwift

class LogOutUseCase {
    
    private let sessionRepository: SessionRepository
    
    init(sessionRepository: SessionRepository) {
        self.sessionRepository = sessionRepository
    }
}

extension LogOutUseCase {
    func execute() -> Observable<LogOutResult> {
        return sessionRepository.logOut()
    }
}
