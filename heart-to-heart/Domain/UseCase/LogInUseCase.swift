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
        self.sessionRepository.test()
    }
    
    func execute() -> Observable<LogInResponse> {
        self.logIn()
    }
    
    private func logIn() -> Observable<LogInResponse> {
        return sessionRepository.logIn(email: self.email!, password: self.password!)
    }
}
