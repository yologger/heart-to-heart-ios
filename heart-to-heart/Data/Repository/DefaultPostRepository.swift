import RxSwift
import UIKit
import ObjectMapper
import Alamofire

final class DefaultPostRepository {
    
    private let postAPI: PostAPI
    
    init(postAPI: PostAPI) {
        self.postAPI = postAPI
    }
}

extension DefaultPostRepository: PostRepository {
    
    
    func createPost(content: String, images: [UIImage?]) -> Observable<Bool> {
        print("This is createPost() from DefaultPostRepository")
        return Observable<Bool>.create { emitter -> Disposable in
            let headers: HTTPHeaders = [
                // "Authorization": "Basic VXNlcm5hbWU6UGFzc3dvcmQ=",
                "Accept": "application/json"
            ]
            
            let parameters: [String: String] = [
                "user_id" : "\(4)"
            ]
            
//            let testImage = UIImage(named: "avatar1.png")!
//            let imageData = testImage.pngData()!
            
            // png, jpg, heic, gif 뭐로 읽든 UIImage()를 생성하면 Screen에서 표시될 수 있는 포맷으로 변환된다.
            let pngImage = UIImage(named: "avatar1.png")!
            let pngImageData = pngImage.pngData()!
            
            let jpgImage = UIImage(named: "avatar1.jpg")!
            let jpgImageData = jpgImage.pngData()!
            
            let heicImage = UIImage(named: "avatar1.heic")!
            let heicImageData = heicImage.pngData()!
            
            let gifImage = UIImage(named: "avatar1.gif")!
            let gifImageData = pngImage.pngData()!
            
            
            AF.upload(multipartFormData: { multipartFormData in
                // Add body
                for (key, value) in parameters {
                    multipartFormData.append("\(value)".data(using: .utf8)!, withName: key, mimeType: "text/plain")
                }
                
                // Add Image
                // multipartFormData.append(imageData, withName: "field", fileName: "avatar1.png", mimeType: "image/*")
                multipartFormData.append(pngImageData, withName: "field", fileName: "avatar1.png", mimeType: "image/jpg")
                multipartFormData.append(jpgImageData, withName: "field", fileName: "avatar1.jpg", mimeType: "image/jpg")
                multipartFormData.append(heicImageData, withName: "field", fileName: "avatarKKKK.jpg", mimeType: "image/jpg")
                multipartFormData.append(gifImageData, withName: "field", fileName: "avatar1.gif", mimeType: "image/jpg")
                
                
            }, to: "\(Constant.API.AuthBaseUrl)/post/post", method: .post, headers: headers )
            .responseString { responseString in
                switch responseString.result {
                case .success(let data):
                    print("susccess")
                    print(data)
                    emitter.onNext(true)
                case .failure(let error):
                    print("failure")
                    print(error.localizedDescription)
                    emitter.onNext(false)
                }
            }
            return Disposables.create()
        }
    }
    
    func test() -> Observable<GetAllPostsResult> {
        
        let postService = postAPI.getPostService()
        
        return Observable<GetAllPostsResult>.create { [weak self] emitter -> Disposable in
            
            postService.getTestData().responseString { responseString in
                switch responseString.result {
                case .success(let data):
                    print("success")
                    guard let statusCode = responseString.response?.statusCode else {
                        emitter.onNext(.failure(.UnknownError))
                        return
                    }
                    switch statusCode {
                    case 200..<300:
                        let getAllPostsSuccessResponse = Mapper<GetAllPostsSuccessResponse>().map(JSONString: data)
                        print("200<=statuscode<300")
                        print("getAllPostsSuccessResponse: \(getAllPostsSuccessResponse)")
                        guard let code = getAllPostsSuccessResponse?.code else {
                            emitter.onNext(.failure(.UnknownError))
                            return
                        }
                        switch code {
                        case -1:
                            emitter.onNext(.failure(.InvalidEmailError))
                        default:
                            emitter.onNext(.failure(.NetworkTimeOutError))
                        }
                    default:
                        print("statusCode: \(statusCode)")
                        let getAllPostsFailureResponse = Mapper<GetAllPostsFailureResponse>().map(JSONString: data)
                        print(getAllPostsFailureResponse)
                        emitter.onNext(.failure(.UnknownError))
                    }
                    emitter.onNext(.success)
                case .failure(let error):
                    emitter.onNext(.failure(.NetworkTimeOutError))
                }
            }
            return Disposables.create()
        }
    }
    
    //    func createPost(title: String, images: [UIImage?]) -> Observable<CreatePostResult> {
    //
    //    }
}
