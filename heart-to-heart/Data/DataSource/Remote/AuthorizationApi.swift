import Foundation
import RxSwift

enum HttpMethod: String {
    case post = "POST"
    case get = "GET"
    case delete = "DELETE"
    case put = "PUT"
}

enum HttpStatusCode: Int {
    case success = 200
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


class NetworkRequest {
    
}

//class NetworkResponse {
//    case success()
//    case error()
//}


protocol AuthorizationApi {
    
    func test()
    
    func signUp(email: String, firstname: String, lastname: String,  nickname: String, password: String) -> Observable<Bool>
}
