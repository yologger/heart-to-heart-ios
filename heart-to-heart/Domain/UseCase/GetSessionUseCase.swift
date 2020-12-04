import RxSwift

class GetSessionUseCase {
    
    private let sessionRepository: SessionRepository
    
    init(sessionRepository: SessionRepository) {
        self.sessionRepository = sessionRepository
    }
    
    func execute() -> Observable<Bool> {
        return sessionRepository.getSessionState()
    }
}
