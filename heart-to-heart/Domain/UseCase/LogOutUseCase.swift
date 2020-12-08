import RxSwift

class LogOutUseCase {
    
    private let sessionRepository: SessionRepository
    
    init(sessionRepository: SessionRepository) {
        self.sessionRepository = sessionRepository
    }
}

extension LogOutUseCase: BaseUseCase {
    func call() -> Observable<LogOutResult> {
        return sessionRepository.logOut()
    }
}
