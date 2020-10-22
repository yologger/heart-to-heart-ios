import Alamofire
import SwiftyJSON
import RxSwift

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
    
}

extension AuthorizationApiImpl: AuthorizationApi {

    
    func test() {
        print("test() from AuthorizationApiImpl")
    }
    
    func signUp(email: String, firstname: String, lastname: String,  nickname: String, password: String) -> Observable<SignUpResponse> {
        
        return Observable<SignUpResponse>.create { observer -> Disposable in
            
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
            ).responseJSON { responseData in
                switch responseData.result {
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
                    print(error)
                    print("Network Error")
                    observer.onNext(.error(.systemError))
                }
            }
            return Disposables.create()
        }
        //        AF.request("http://localhost:8000/test/test").responseJSON { responseJSON in
        //            switch responseJSON.result {
        //                case .success(let data):
        //                    print(data)
        //                    // 47 bytes
        //                case .failure(let error):
        //                    print(error)
        //            }
        //        }
    }
}
