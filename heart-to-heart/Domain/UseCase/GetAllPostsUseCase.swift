import RxSwift

class GetAllPostsUseCase {
    
    private let postRepository: PostRepository
    
    init(postRepository: PostRepository) {
        self.postRepository = postRepository
    }
    
    func execute() -> Observable<GetAllPostsResult> {
        return self.postRepository.test()
        .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
        .observeOn(MainScheduler.instance)
    }
}
