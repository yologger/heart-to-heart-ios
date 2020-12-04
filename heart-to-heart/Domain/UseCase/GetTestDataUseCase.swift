import RxSwift

class GetTestDataUseCase {
    
    private let postRepository: PostRepository
    
    init(postRepository: PostRepository) {
        self.postRepository = postRepository
    }
    
    func execute() -> Observable<GetAllPostsResult> {
        print("execute() from GetAllPostsUseCase")
        return self.postRepository.test()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.instance)
    }
}
