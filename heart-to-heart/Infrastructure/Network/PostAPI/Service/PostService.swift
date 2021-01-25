import Alamofire
import RxSwift
import Foundation
import UIKit
import TLPhotoPicker

final class PostService {
    
    private let authInterceptor: AuthInterceptor
    
    init(authInterceptor: AuthInterceptor) {
        self.authInterceptor = authInterceptor
    }
    
    func createPost(userId: Int, content: String?, assets: [TLPHAsset]?) -> DataRequest {
        
        let headers: HTTPHeaders = [
            // "Authorization": "Basic VXNlcm5hbWU6UGFzc3dvcmQ=",
            // "Accept": "application/json"
        ]
        
        var parameters: [String: String] = [
            "user_id": "\(userId)"
        ]
        
        if (content != nil) {
            parameters["content"] = content
        }
        
        return AF.upload(multipartFormData: { multipartFormData in
            // Add body
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key, mimeType: "text/plain")
            }
            
            // Add Images
            if (assets != nil) {
                for asset in assets! {
                    let image = asset.fullResolutionImage
                    let imageData = image?.pngData()
                    let ext = asset.extType().rawValue
                    let filename = asset.originalFileName!
                    print("ext: \(ext)")
                    print("filename: \(filename)")
                    multipartFormData.append(imageData!, withName: "field", fileName: filename, mimeType: "image/\(ext)")
                }
            }
            
        }, to: "\(Constant.API.AuthBaseUrl)/post/post",
        method: .post,
        headers: headers,
        interceptor: self.authInterceptor)
        .validate()
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



