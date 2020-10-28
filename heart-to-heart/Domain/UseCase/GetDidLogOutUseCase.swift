import RxSwift

class GetDidLogOutUseCase {
    
    private let sessionRepository: SessionRepository
    
    init(sessionRepository: SessionRepository) {
        self.sessionRepository = sessionRepository
    }
    
    func execute() -> Observable<Void> {
        return self.sessionRepository.getDidLogOut()
    }
}
