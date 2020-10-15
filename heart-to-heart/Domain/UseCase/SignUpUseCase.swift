import RxSwift

class SignUpUseCase: BaseUseCase {
    
    private let sessionRepository: SessionRepository
    
    init(sessionRepository: SessionRepository) {
        self.sessionRepository = sessionRepository
    }
    
    func execute() {
        print("execute() from SignUpUseCase")
        sessionRepository.test()
    }
}
