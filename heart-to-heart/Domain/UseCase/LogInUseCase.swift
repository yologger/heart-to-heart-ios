import RxSwift

class LogInUseCase {

    var email: String?
    var password: String?
    
    private let sessionRepository: SessionRepository
    
    init(sessionRepository: SessionRepository) {
        self.sessionRepository = sessionRepository
    }
    
    func test() {
        print("LogInUsecase")
    }
    
    func execute() -> Observable<LogInResult> {
        self.logIn()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.instance)
    }
    
    private func logIn() -> Observable<LogInResult> {
        return sessionRepository.logIn(email: self.email!, password: self.password!)
    }
}
