import RxSwift
import ObjectMapper

final class DefaultPostRepository {
    
    private let postAPI: PostAPI
    
    init(postAPI: PostAPI) {
        self.postAPI = postAPI
    }
}

extension DefaultPostRepository: PostRepository {
    
    func test() -> Observable<GetAllPostsResult> {
        
        print("test() from DefaultPostRepository")
        
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
    
}
