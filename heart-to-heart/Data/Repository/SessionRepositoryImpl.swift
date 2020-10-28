import RxSwift
import Alamofire
import SwiftyJSON

final class SessionRepositoryImpl {
    
    private let authorizationApi: AuthorizationApi
    private let tokenStorage: TokenStorage
    
    private var accessToken: AccessToken?
    private var refreshToken: RefreshToken?
    
    private var sessionState: Session?
    
    private let logOutSubject = PublishSubject<Void>()
    private let logInSubject = PublishSubject<Void>()
    
    init(authorizationApi: AuthorizationApi, tokenStorage: TokenStorage) {
        self.authorizationApi = authorizationApi
        self.tokenStorage = tokenStorage
        self.loadSession()
    }
    
    private func loadSession() {
        self.accessToken = tokenStorage.getAccessToken()
        self.refreshToken = tokenStorage.getRefreshToken()
        if(self.accessToken != nil && self.refreshToken != nil) {
            self.sessionState = Session(accessToken: self.accessToken?.accessToken, refreshToken: self.refreshToken?.refreshToken)
        }
    }
}

extension SessionRepositoryImpl: SessionRepository {
    
    func logOut() {
        
    }
    
    func test() {
        print("test() from SessionRepositoryImpl")
        tokenStorage.test()
    }
    
    func signUp(email: String, firstname: String, lastname: String,  nickname: String, password: String) -> Observable<SignUpResponse> {
        return authorizationApi.signUp(email: email, firstname: firstname, lastname: lastname, nickname: nickname, password: password)
    }
    
    func logIn(email: String, password: String) -> Observable<LogInResponse> {
        
        return authorizationApi.logIn(email: email, password: password)
            .do(onNext: { [weak self] (logInResponse) in
                switch logInResponse {
                case .success(let logInData):
                    guard let accessToken = logInData.accessToken, let refreshToken = logInData.refreshToken else { return }
                    try self?.setAccessToken(accessToken: accessToken)
                    try self?.setRefreshToken(refreshToken: refreshToken)
                    break
                case .error:
                    break
                }
            })
    }
    
    private func setAccessToken(accessToken: String) throws {
        try self.tokenStorage.setAccessToken(accessToken: accessToken)
    }
    
    private func setRefreshToken(refreshToken: String) throws {
        try self.tokenStorage.setRefreshToken(refreshToken: refreshToken)
    }
    
    func getSessionState() -> Session? {
        return self.sessionState
    }
    
    func getDidLogIn() -> Observable<Void> {
        return self.logInSubject.asObserver()
    }
    
    func getDidLogOut() -> Observable<Void> {
        return self.logOutSubject.asObserver()
    }
}
