import Alamofire
import SwiftyJSON
import RxSwift

final class AuthorizationApiImpl {
    
}

extension AuthorizationApiImpl: AuthorizationApi {
    
    func test() {
        print("test() from AuthorizationApiImpl")
    }
    
    func signUp(email: String, firstname: String, lastname: String,  nickname: String, password: String) -> Observable<Bool> {
        
        return Observable<Bool>.create { observer -> Disposable in
            observer.onNext(true)
            return Disposables.create()
        }
        
        
        
//        // Headers
//        let headers: HTTPHeaders = [
//            "Authorization": "Basic VXNlcm5hbWU6UGFzc3dvcmQ=",
//            "Accept": "application/json"
//        ]
//
//        // URL Paramaters
//        let parameters: [String: String] = [
//            "email": email,
//            "firstname": firstname,
//            "lastname": lastname,
//            "nickname": nickname,
//            "password": password
//        ]
//
//        AF.request(
//            "http://localhost:8000/auth/signup",
//            method: .post,
//            parameters: parameters,
//            encoder: URLEncodedFormParameterEncoder.default,
//            headers: headers
//        ).responseJSON { responseData in
//            switch responseData.result {
//            case .success(let data):
//                let jsonObject = JSON(data)
//                if (jsonObject["code"] == -1) {
//                    print("Already exist.")
//                } else {
//                    print("Successfully Signed Up")
//                }
//            case .failure(let error):
//                // Network Error
//                print(error)
//                print("Network Error")
//            }
//        }
        
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
