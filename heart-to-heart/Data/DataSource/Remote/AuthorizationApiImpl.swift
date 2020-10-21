import Alamofire

final class AuthorizationApiImpl {
    
}

extension AuthorizationApiImpl: AuthorizationApi {
    
    func test() {
        print("test() from AuthorizationApiImpl")
    }
    
    func signUp(email: String, fullname: String, nickname: String, password: String) {
        print("signUp() from AuthorizationApi")
        
        // Headers
        let headers: HTTPHeaders = [
            "Authorization": "Basic VXNlcm5hbWU6UGFzc3dvcmQ=",
            "Accept": "application/json"
        ]
        
        // URL Paramaters
        let parameters: [String: String] = [
            "email": email,
            "fullname": fullname,
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
                print(data)
            case .failure(let error):
                print(error)
            }
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
