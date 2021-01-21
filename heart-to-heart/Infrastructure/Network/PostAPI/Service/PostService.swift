import Alamofire
import RxSwift
import Foundation
import UIKit

final class PostService {
    
    private let authInterceptor: AuthInterceptor
    
    init(authInterceptor: AuthInterceptor) {
        self.authInterceptor = authInterceptor
    }
    
    func getTestData() -> DataRequest {
 
        // Headers
//        let headers: HTTPHeaders = [
//            "Authorization": "Basic VXNlcm5hbWU6UGFzc3dvcmQ=",
//            "Accept": "application/json"
//        ]
        let headers: HTTPHeaders = [
            "Content-Type": "multipart/form-data"
        ]

        return AF.request(
            "\(Constant.API.AuthBaseUrl)/post/test",
            method: .get,
            headers: headers,
            interceptor: self.authInterceptor
        ).validate()
    }
    
//    func createPost() -> DataRequest {
//
//        let headers: HttpHeaders = [
//            "Content-type": ""
//        ]
//
//    }

}



