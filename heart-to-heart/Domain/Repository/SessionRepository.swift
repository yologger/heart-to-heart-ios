import RxSwift

protocol SessionRepository: BaseRepository {
    func getSessionState() -> Observable<Bool>
    func signUp(email: String, firstName: String, lastName: String,  nickname: String, password: String) -> Observable<SignUpResponse>
    func logIn(email: String, password: String) -> Observable<LogInResult>
    func logOut() -> Observable<LogOutResult>
}
