import RxSwift

class GetAllPostsUseCase: BaseUseCase {
    
    private let postRepository: PostRepository
    
    init(postRepository: PostRepository) {
        self.postRepository = postRepository
    }
    
    func execute() {
        print("execute() from GetAllPostsUseCase")
        self.postRepository.test()
    }
}
