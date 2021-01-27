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

    func getAllPosts(pageNumber: Int, pageSize: Int) -> Observable<GetAllPostsResult> {
        let postService = postAPI.getPostService()
        return Observable.create { emitter -> Disposable in
            postService.getAllPost(page: pageNumber, size: pageSize)
                .responseString { responseString in
                    switch responseString.result {
                    case .success(let data):
                        guard let statusCode = responseString.response?.statusCode else { return }
                        switch statusCode {
                        case 200..<300:
                            let response = Mapper<GetAllPostsSuccessResponse>().map(JSONString: data)
                            emitter.onNext(.success(GetAllPostsData(posts: response?.data?.posts)))
                        default:
                            emitter.onNext(.failure(.UnknownError))
                        }
                    case .failure(let error):
                        emitter.onNext(.failure(.NetworkTimeOutError))
                    }
                }
            return Disposables.create()
        }
    }
    
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
}
