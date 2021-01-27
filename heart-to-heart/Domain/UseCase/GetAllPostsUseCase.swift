import RxSwift

final class GetAllPostsUseCase {
    
    private let postRepository: PostRepository
    var pageNumber: Int?
    var pageSize: Int?
    
    init(postRepository: PostRepository) {
        self.postRepository = postRepository
    }
}

extension GetAllPostsUseCase: BaseUseCase {
    
    typealias Result = GetAllPostsResult
    
    func call() -> Observable<GetAllPostsResult> {
        guard let _pageNumber = pageNumber, let _pageSize = pageSize else {
            return Observable.empty()
        }
        return postRepository.getAllPosts(pageNumber: _pageNumber, pageSize: _pageSize)
    }
}
