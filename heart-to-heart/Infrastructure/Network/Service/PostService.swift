import Alamofire
import RxSwift
import Foundation

final class PostService {
    
    private let authInterceptor: AuthInterceptor
    
    init(authInterceptor: AuthInterceptor) {
        self.authInterceptor = authInterceptor
    }
    
    func getTestData() -> DataRequest {
 
        // Headers
        let headers: HTTPHeaders = [
            "Authorization": "Basic VXNlcm5hbWU6UGFzc3dvcmQ=",
            "Accept": "application/json"
        ]

        return AF.request(
            "\(Constants.AuthBaseUrl)/post/test",
            method: .get,
            headers: headers,
            interceptor: self.authInterceptor
        ).validate()
    }
}


