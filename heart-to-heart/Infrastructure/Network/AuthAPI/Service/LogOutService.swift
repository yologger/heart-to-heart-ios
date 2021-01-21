import Alamofire
import SwiftyJSON
import RxSwift

class LogOutService {
    
    private let authInterceptor: AuthInterceptor
    private let sessionStorage: SessionStorage
    
    init(authInterceptor: AuthInterceptor, sessionStorage: SessionStorage) {
        self.authInterceptor = authInterceptor
        self.sessionStorage = sessionStorage
    }
    
    func logOut() -> DataRequest {
        
        let accessToken = sessionStorage.getAccessToken()!
        
        // Headers
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
            "Accept": "application/json"
        ]
        
        // URL Paramaters
        let parameters: [String: String] = [
            "accessToken": accessToken
        ]
        
        return AF.request(
            "\(Constant.API.AuthBaseUrl)/auth/logout",
            method: .post,
            parameters: parameters,
            encoder: URLEncodedFormParameterEncoder.default,
            headers: headers,
            interceptor: self.authInterceptor
        ).validate()
    }
}
