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
    
    func execute(){
        
//        return Observable<Bool>.create { emitter -> Disposable in
//            emitter.onNext(true)
//            emitter.onCompleted()
//            return Disposables.create()
//        }
    }
}
