import Alamofire
import SwiftyJSON
import RxSwift
import UIKit

final class UpdateAvatarImageService {
    
    private let authInterceptor: AuthInterceptor
    
    init(authInterceptor: AuthInterceptor) {
        self.authInterceptor = authInterceptor
    }
    
    func updateAvatarImage(userId: Int, image: UIImage) -> DataRequest {
        let headers: HTTPHeaders = [
            // "Authorization": "Basic VXNlcm5hbWU6UGFzc3dvcmQ=",
            // "Accept": "application/json"
        ]
        
        let parameters: [String: String] = [
            "user_id": "\(userId)"
        ]
        
        return AF.upload(multipartFormData: { multipartFormData in
            // Add body
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key, mimeType: "text/plain")
            }
            
            // Add Image
            let imageData = image.pngData()
            multipartFormData.append(imageData!, withName: "avatar", fileName: "\(userId)_avatar.png", mimeType: "image/*")
            
            
        }, to: "\(Constant.API.AuthBaseUrl)/auth/avatar",
        method: .post,
        headers: headers,
        interceptor: self.authInterceptor)
        .validate()
    }
    
}
