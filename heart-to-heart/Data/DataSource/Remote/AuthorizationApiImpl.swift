import Alamofire
import SwiftyJSON
import RxSwift

enum LogInResponse {
    case success(LogInData)
    case error(LogInError)
}

struct LogInData {
    var accessToken: String?
    var refreshToken: String?
}

enum LogInError: Int {
    case wrongEmailError = -1
    case wrongPasswordError = -2
    case internalServerError = -3
    case networkError = -4
    case unknownError = -5
}

enum SignUpResponse {
    case success
    case error(SignUpError)
}

enum SignUpError: Int {
    case accountAlreadyExist = -1
    case badRequest = 400
    case authenticationFailed = 401
    case forbidden = 403
    case notFoundException = 404
    case contentLengthError = 413
    case quotaExceeded = 429
    case systemError = 500
    case endpointError = 503
    case timeout = 504
}


final class AuthorizationApiImpl {
    let keyChainService = KeyChainService()
}

extension AuthorizationApiImpl: AuthorizationApi {
    
    func test() {
        print("test() from AuthorizationApiImpl")
    }
    
    func signUp(email: String, firstname: String, lastname: String,  nickname: String, password: String) -> Observable<SignUpResponse> {
        
        return Observable<SignUpResponse>.create { [weak self] observer -> Disposable in
            
            // Headers
            let headers: HTTPHeaders = [
                "Authorization": "Basic VXNlcm5hbWU6UGFzc3dvcmQ=",
                "Accept": "application/json"
            ]
            
            // URL Paramaters
            let parameters: [String: String] = [
                "email": email,
                "firstname": firstname,
                "lastname": lastname,
                "nickname": nickname,
                "password": password
            ]
            
            AF.request(
                "http://localhost:8000/auth/signup",
                method: .post,
                parameters: parameters,
                encoder: URLEncodedFormParameterEncoder.default,
                headers: headers
            ).responseJSON { responseJSON in
                switch responseJSON.result {
                case .success(let data):
                    let jsonObject = JSON(data)
                    if (jsonObject["code"] == -1) {
                        print("Already exist.")
                        observer.onNext(.error(.accountAlreadyExist))
                    } else {
                        print("Successfully Signed Up")
                        observer.onNext(.success)
                    }
                case .failure(let error):
                    // Network Error
                    print(error.localizedDescription)
                    print("Server Error")
                    observer.onNext(.error(.systemError))
                }
            }
            return Disposables.create()
        }
    }
    
    func logIn(email: String, password: String) -> Observable<LogInResponse> {
        
        return Observable<LogInResponse>.create { [weak self] observer -> Disposable in
            
            // Headers
            let headers: HTTPHeaders = [
                "Authorization": "Basic VXNlcm5hbWU6UGFzc3dvcmQ=",
                "Accept": "application/json"
            ]
            
            // URL Paramaters
            let parameters: [String: String] = [
                "email": email,
                "password": password
            ]
            
            AF.request(
                "http://localhost:8000/auth/login",
                method: .post,
                parameters: parameters,
                encoder: URLEncodedFormParameterEncoder.default,
                headers: headers
            ).responseJSON { responseJSON in
                switch responseJSON.result {
                case .success(let data):
                    let jsonObject = JSON(data)
                    switch jsonObject["code"] {
                    
                    case -1:
                        // Wrong Email
                        observer.onNext(.error(.wrongEmailError))
                    case -2:
                        // Wrong Password
                        observer.onNext(.error(.wrongPasswordError))
                    case -3:
                        // Internal Server Error
                        observer.onNext(.error(.internalServerError))
                    case 1:
                        // Success
                        let accessToken = jsonObject["data"]["access_token"].string
                        let refreshToken = jsonObject["data"]["refresh_token"].string
                        
                        let logInData = LogInData(accessToken: accessToken, refreshToken: refreshToken)
                        
//                        self?.keyChainService.save(key: "accessToken", value: accessToken!)
//                        self?.keyChainService.save(key: "refreshToken", value: refreshToken!)

//                        print(self?.keyChainService.load(key: "accessToken"))
  
                        observer.onNext(.success(logInData))
                        
                    default:
                        observer.onNext(.error(.unknownError))
                    }
                case .failure(let error):
                    // Network Error
                    observer.onNext(.error(.networkError))
                }
            }
            return Disposables.create()
        }
    }
}
