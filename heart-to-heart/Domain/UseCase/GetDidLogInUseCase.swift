import RxSwift

class GetDidLogInUseCase {

    private let sessionRepository: SessionRepository
    
    init(sessionRepository: SessionRepository) {
        self.sessionRepository = sessionRepository
    }
    
    func test() {
        self.sessionRepository.test()
    }
    
    func execute() -> Observable<Void> {
        return self.sessionRepository.getDidLogIn()
    }
}
