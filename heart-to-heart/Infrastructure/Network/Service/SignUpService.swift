import Alamofire
import SwiftyJSON
import RxSwift

final class SignUpService {
    
    func signUp(email: String, firstName: String, lastName: String, nickname: String, password: String) -> Observable<SignUpResponse> {
        
        return Observable<SignUpResponse>.create { emitter -> Disposable in
            
            // Headers
            let headers: HTTPHeaders = [
                // "Authorization": "Basic VXNlcm5hbWU6UGFzc3dvcmQ=",
                "Accept": "application/json"
            ]
            
            // URL Paramaters
            let parameters: [String: String] = [
                "email": email,
                "firstName": firstName,
                "lastName": lastName,
                "nickname": nickname,
                "password": password
            ]
            
            AF.request(
                "\(Constants.AuthBaseUrl)/auth/signup",
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
                        emitter.onNext(.error(.accountAlreadyExist))
                    } else {
                        print("Successfully Signed Up")
                        emitter.onNext(.success)
                    }
                case .failure(let error):
                    // Network Error
                    print(error.localizedDescription)
                    print("Server Error")
                    emitter.onNext(.error(.systemError))
                }
            }
            return Disposables.create()
        }
    }
}
