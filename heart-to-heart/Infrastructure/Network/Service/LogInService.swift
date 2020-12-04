import Alamofire
import SwiftyJSON
import RxSwift

final class LogInService {
    
    func logIn(email: String, password: String) -> DataRequest {
        
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
        
        return AF.request(
            "\(Constants.AuthBaseUrl)/auth/login",
            method: .post,
            parameters: parameters,
            encoder: URLEncodedFormParameterEncoder.default,
            headers: headers
        )
    }
}
