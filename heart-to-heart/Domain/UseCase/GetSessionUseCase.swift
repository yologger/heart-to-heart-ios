import RxSwift

class GetSessionUseCase {
    
    private let sessionRepository: SessionRepository
    
    init(sessionRepository: SessionRepository) {
        self.sessionRepository = sessionRepository
    }
}

extension GetSessionUseCase: BaseUseCase {
    func call() -> Observable<Bool> {
        return sessionRepository.getSessionState()
    }
}
