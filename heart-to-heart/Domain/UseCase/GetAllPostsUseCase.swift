import RxSwift

final class GetAllPostsUseCase {
    
    private let postRepository: PostRepository
    
    init(postRepository: PostRepository) {
        self.postRepository = postRepository
    }
}

extension GetAllPostsUseCase: BaseUseCase {
    
    typealias Result = GetAllPostsResult
    
    func call() -> Observable<GetAllPostsResult> {
        return postRepository.getAllPosts()
    }
}
