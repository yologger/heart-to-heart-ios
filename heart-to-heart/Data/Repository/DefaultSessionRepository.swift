import RxSwift
import Alamofire
import SwiftyJSON
import ObjectMapper
import UIKit

final class DefaultSessionRepository {
    
    private let authAPI: AuthAPI
    private let sessionStorage: SessionStorage
    
    private var _session: UserSession?
    private var _sessionState: Session?
    
    init(authAPI: AuthAPI, sessionStorage: SessionStorage) {
        self.authAPI = authAPI
        self.sessionStorage = sessionStorage
        self.loadSession()
    }
    
    private func loadSession() {
    }
    
    private func removeSession() {
    }
    
    private func saveSession(session: Session) {
        
    }
}

extension DefaultSessionRepository: SessionRepository {
    
    func getSessionState() -> Observable<Bool> {
        return sessionStorage.getSessionState()
    }
    
    func fetchCurrentUserInformation() -> Observable<FetchCurrentUserInformationResult> {
        return Observable<FetchCurrentUserInformationResult>.create { [weak self] emitter in
            
            let currentSession = self?.sessionStorage.getCurrentSession()
            if (currentSession != nil) {
                emitter.onNext(.success(currentSession!))
            } else {
                emitter.onNext(.failure)
            }
            return Disposables.create()
        }
    }
    
    func signUp(email: String, firstName: String, lastName: String,  nickname: String, password: String) -> Observable<SignUpResponse> {
        let signUpService = authAPI.getSignUpService()
        return signUpService.signUp(email: email, firstName: firstName, lastName: lastName, nickname: nickname, password: password)
    }
    
    func logIn(email: String, password: String) -> Observable<LogInResult> {
        let logInService = authAPI.getLogInService()
        
        return Observable<LogInResult>.create { [weak self] emitter -> Disposable in
            logInService.logIn(email: email, password: password).responseString { responseString in
                switch responseString.result {
                case .success(let data):
                    guard let statusCode = responseString.response?.statusCode else { return }
                    switch statusCode {
                    case 200..<300:
                        let logInSuccessResponse = Mapper<LogInSuccessResponse>().map(JSONString: data)
                        guard let accessToken = logInSuccessResponse?.data?.accessToken,
                              let refreshToken = logInSuccessResponse?.data?.refreshToken,
                              let userId = logInSuccessResponse?.data?.userId,
                              let email = logInSuccessResponse?.data?.email,
                              let nickname = logInSuccessResponse?.data?.nickname
                        else { return }
                        let url = logInSuccessResponse?.data?.url
                        let tokens = Tokens(accessToken: accessToken, refreshToken: refreshToken )
                        let profile = Profile(userId: userId, email: email, nickname: nickname, url: url)
                        let session = UserSession(email: email, profile: profile, tokens: tokens)
                        self?._session = session
                        self?.sessionStorage.setSession(session: session)
                        emitter.onNext(.success)
                        break
                    default:
                        let logInFailureResponse = Mapper<LogInFailureResponse>().map(JSONString: data)
                        guard let code = logInFailureResponse?.code else { return }
                        switch code {
                        case -1:
                            emitter.onNext(.failure(.InvalidEmailError))
                        case -2:
                            emitter.onNext(.failure(.InvalidPasswordError))
                        default:
                            emitter.onNext(.failure(.UnknownError))
                        }
                    }
                case .failure(let error):
                    // NETWORK ERROR
                    switch error._code {
                    case NSURLErrorTimedOut:
                        emitter.onNext(.failure(.NetworkTimeOutError))
                    default:
                        emitter.onNext(.failure(.UnknownError))
                    }
                }
            }
            return Disposables.create()
        }
        
    }
    
    func logOut() -> Observable<LogOutResult> {
        let logOutService = authAPI.getLogOutService()
        
        return Observable.create { [weak self] emitter -> Disposable in
            logOutService.logOut().responseString { responseString in
                switch responseString.result {
                case .success(let data):
                    guard let statusCode = responseString.response?.statusCode else { return }
                    switch statusCode {
                    case 200..<300:
                        print("LOG OUT REQUEST SUCCESS!")
                        print(data)
                        self?.sessionStorage.removeSession()
                        emitter.onNext(.success)
                    default:
                        print("LOG OUT REQUEST FAIKURE!")
                        let logOutFailureResponse = Mapper<LogOutFailureResponse>().map(JSONString: data)
                        print(logOutFailureResponse)
                        guard let code = logOutFailureResponse?.code else {
                            emitter.onNext(.failure(.UnknownError))
                            return
                        }
                        
                        switch code {
                        case -11: print("Refresh Token Error / No Refresh Token in request body")
                        case -12: print("Refresh Token Error / Invalid Refresh Token")
                        case -13: print("Refresh Token Error / Refresh Token has expired")
                        case -14: print("Refresh Token Error / Invalid Refresh Token. User does not exists")
                        case -15: print("Refresh Token Error / Invalid Refresh Token. User already has logged out")
                        case -16: print("Refresh Token Error / Invalid Refresh Token. Old Refresh Token")
                        default: print("Unknown Error")
                            
                        }
                        self?._session = nil
                        self?.sessionStorage.removeSession()
                        emitter.onNext(.failure(.UnknownError))
                    }
                    
                case .failure(let error):
                    self?.sessionStorage.removeSession()
                    switch error._code {
                    case NSURLErrorTimedOut:
                        emitter.onNext(.failure(.NoAccessTokenInBody))
                    default:
                        emitter.onNext(.failure(.UnknownError))
                    }
                }
            }
            return Disposables.create()
        }
    }
    
    func updateAvatarImage(image: UIImage) -> Observable<UpdateAvatarImageResult> {
        guard let userId = sessionStorage.getUserId() else { return Observable.empty() }
        let service = authAPI.getUpdateAvatarImageService()
        return Observable<UpdateAvatarImageResult>.create { emitter  -> Disposable in
            service.updateAvatarImage(userId: userId, image: image)
                .responseString { responseString in
                    switch responseString.result {
                    case .success(let data):
                        guard let statusCode = responseString.response?.statusCode else { return }
                        switch statusCode {
                        case 200..<300:
                            let response = Mapper<UpdateAvatarImageSuccessResponse>().map(JSONString: data)
                            let imageUrl = response?.url
                            emitter.onNext(.success(UpdateAvatarImageData(url: imageUrl)))
                        default:
                            emitter.onNext(.failure)
                        }
                    case .failure(let error):
                        print(error)
                        emitter.onNext(.failure)
                    }
                }
            return Disposables.create()
        }
    }
}
