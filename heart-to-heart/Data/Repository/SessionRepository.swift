import RxSwift

class SessionRepository: BaseRepository {

    private let logInSubject = PublishSubject<Void>()
    private let logOutSubject = PublishSubject<Void>()
    
    var didLogIn: Observable<Void> {
        return self.logInSubject.asObservable()
    }

    var didLogOut: Observable<Void> {
        return self.logOutSubject.asObservable()
    }

    func signUp() {
        
    }
    
    func logIn() {
        
    }

    func logOut() {
        
    }
    
    func withDraw() {
        
    }
    
    func test() {
        print("test() from SessionRepository")
    }
}
