import Foundation
import RxSwift


protocol AuthorizationApi {
    
    func test()
    
    func signUp(email: String, firstname: String, lastname: String,  nickname: String, password: String) -> Observable<SignUpResponse>
    
    func logIn(email: String, password: String) -> Observable<LogInResponse>
    
    // func logOut() -> Observable<LogOutResponse>
}
