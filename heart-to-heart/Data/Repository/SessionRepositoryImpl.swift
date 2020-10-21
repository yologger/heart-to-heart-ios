import RxSwift
import Alamofire

final class SessionRepositoryImpl {
    
    private let authorizationApi: AuthorizationApi
    
    init(authorizationApi: AuthorizationApi) {
        self.authorizationApi = authorizationApi
    }
}

extension SessionRepositoryImpl: SessionRepository {
    
    func test() {
        print("test() from SessionRepositoryImpl")
    }
    
    func signUp(email: String, fullname: String, nickname: String, password: String) {
        print("signUp() from SessionRepositoryImpl")
        authorizationApi.signUp(email: email, fullname: fullname, nickname: nickname, password: password)
    }
}
