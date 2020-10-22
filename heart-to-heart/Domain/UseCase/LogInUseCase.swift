import RxSwift

final class LogInUseCase {
    
    var email: String?
    var password: String?
    
    private let sessionRepository: SessionRepository
    
    init(sessionRepository: SessionRepository) {
        self.sessionRepository = sessionRepository
    }
}

extension LogInUseCase: BaseUseCase{
    
    func test() {
        print("LogInUsecase")
        self.sessionRepository.test()
    }
    
    func execute(){
        self.logIn()
    }
    
    func logIn() {
        guard let email = self.email, let password = self.password else { return }
        
    }
}
