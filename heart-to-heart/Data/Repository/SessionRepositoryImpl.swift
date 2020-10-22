import RxSwift
import Alamofire
import SwiftyJSON



final class SessionRepositoryImpl {
    
    private let authorizationApi: AuthorizationApi
    
    init(authorizationApi: AuthorizationApi) {
        self.authorizationApi = authorizationApi
    }
}

extension SessionRepositoryImpl: SessionRepository {
    
    func signUp(email: String, firstname: String, lastname: String, nickname: String, password: String) {
        
    }
    
    func logIn(email: String, password: String) {
        
    }
    
    func logOut() {
        
    }
    
    func test() {
        print("test() from SessionRepositoryImpl")
    }
    
    func signUp(email: String, firstname: String, lastname: String,  nickname: String, password: String) -> Observable<SignUpResponse> {
        
        return authorizationApi.signUp(email: email, firstname: firstname, lastname: lastname, nickname: nickname, password: password)
    }
}
