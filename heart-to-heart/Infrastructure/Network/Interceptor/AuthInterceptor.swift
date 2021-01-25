import Alamofire
import Foundation
import ObjectMapper

class AuthInterceptor: Interceptor {
    
    let sessionStorage: SessionStorage
    
    init(sessionStorage: SessionStorage) {
        self.sessionStorage = sessionStorage
        super.init()
    }
    
    let retryLimit = 3
    
    // adapt()  Request를 보내기 전에 호출된다.
    override func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        guard let accessToken = sessionStorage.getAccessToken() else {
            //
            return
        }
        print("adapt() from AuthInterceptor")
        var urlRequest = urlRequest
        urlRequest.headers.add(.authorization(bearerToken: accessToken))
        completion(.success(urlRequest))
    }
    
    override func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        
        print("retry() from AuthInterceptor")
        
        //        guard request.retryCount < retryLimit else {
        //            completion(.doNotRetry)
        //            return
        //        }
        
        guard let response = request.task?.response as? HTTPURLResponse else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        let statusCode = response.statusCode
        
        if (statusCode == 401) {
            refreshToken { isSuccess in
                // isSuccess ? completion(.retry) : completion(.doNotRetry)
                
                if (isSuccess) {
                    print("refreshToken() success")
                    completion(.retry)
                } else {
                    print("refreshToken() failure")
                    completion(.doNotRetry)
                }
            }
        } else {
            completion(.doNotRetry)
        }
    }
    
    func refreshToken(completion: @escaping (_ isSuccess: Bool) -> Void) {
        
        print("refreshToken() from AuthInterceptor")
        let refreshToken = sessionStorage.getRefreshToken()
        let parameters = [
            "refresh_token": refreshToken
        ]
        
        AF.request(
            "\(Constant.API.AuthBaseUrl)/auth/token",
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default
        ).responseString { [weak self] responseString  in
            switch responseString.result {
            case .success(let data):
                print("success")
                guard let statusCode = responseString.response?.statusCode else { return }
                switch statusCode {
                case 200..<300:
                    let refreshTokenSuccessResponse = Mapper<RefreshTokensSuccessResponse>().map(JSONString: data)
                    print("refreshTokenSuccessResponse: \(refreshTokenSuccessResponse)")
                    guard let newAccessToken = refreshTokenSuccessResponse?.data?.accessToken, let newRefreshToken = refreshTokenSuccessResponse?.data?.refreshToken else {
                        completion(false)
                        return
                    }
                    let newTokens = Tokens(accessToken: newAccessToken, refreshToken: newRefreshToken)
                    self?.sessionStorage.updateTokens(tokens: newTokens)
                    completion(true)
                default:
                    let refreshTokenFailureResponse = Mapper<RefreshTokensFailureResponse>().map(JSONString: data)
                    print("refreshTokenFailureResponse: \(refreshTokenFailureResponse)")
                    self?.sessionStorage.removeSession()
                    completion(false)
                }
            case .failure(let error):
                print("failure")
                completion(false)
            }
        }
    }
}
