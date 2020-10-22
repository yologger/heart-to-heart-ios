import RxSwift

protocol SessionRepository: BaseRepository {
    
    func test()
    
    func signUp(email: String, firstname: String, lastname: String,  nickname: String, password: String) -> Observable<SignUpResponse>
    
    func logIn(email: String, password: String)
    
    func logOut()
}
