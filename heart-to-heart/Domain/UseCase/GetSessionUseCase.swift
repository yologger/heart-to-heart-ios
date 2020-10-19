import RxSwift

class GetSessionUseCase: BaseUseCase {
    
    private let sessionRepository: SessionRepository
    
    init(sessionRepository: SessionRepository) {
        self.sessionRepository = sessionRepository
    }
    
    func execute() {
        print("execute() from GetSessionUseCase")
        sessionRepository.test()
    }
}
