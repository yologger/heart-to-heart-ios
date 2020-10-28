import RxSwift

class GetSessionUseCase {
    
    private let sessionRepository: SessionRepository
    
    init(sessionRepository: SessionRepository) {
        self.sessionRepository = sessionRepository
    }

    func execute() -> Session? {
        self.sessionRepository.getSessionState()
    }
}
