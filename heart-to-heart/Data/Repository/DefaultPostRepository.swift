import RxSwift
import UIKit
import ObjectMapper
import Alamofire
import TLPhotoPicker

final class DefaultPostRepository {
    
    private let postAPI: PostAPI
    private let sessionStorage: SessionStorage
    
    init(postAPI: PostAPI, sessionStorage: SessionStorage) {
        self.postAPI = postAPI
        self.sessionStorage = sessionStorage
    }
}

extension DefaultPostRepository: PostRepository {
    func createPost(content: String?, assets: [TLPHAsset]?) -> Observable<CreatePostResult> {
        let userId = sessionStorage.getUserId()!
        let postService = postAPI.getPostService()
        return Observable<CreatePostResult>.create { emitter in
            postService.createPost(userId: userId, content: content, assets: assets)
            .responseString { responseString in
                switch responseString.result {
                case .success(let data):
                    guard let statusCode = responseString.response?.statusCode else { return }
                    switch statusCode {
                    case 200..<300:
                        let response = Mapper<CreatePostSuccessResponse>().map(JSONString: data)
                        let post = response?.data?.post
                        emitter.onNext(.success(CreatePostData(post: post!)))
                    default:
                        let response = Mapper<CreatePostFailureResponse>().map(JSONString: data)
                        emitter.onNext(.failure(.UnknownError))
                    }
                case .failure(let error):
                    print("failure")
                    print(error.localizedDescription)
                    emitter.onNext(.failure(.UnknownError))
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
