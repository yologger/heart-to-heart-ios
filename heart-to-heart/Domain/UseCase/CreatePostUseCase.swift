import RxSwift

final class CreatePostUseCase {
    
    private let postRepository: PostRepository
    
    private var text: String?
    
    init(postRepository: PostRepository) {
        self.postRepository = postRepository
    }
}

extension CreatePostUseCase: BaseUseCase {
    
    func call() -> Observable<Bool> {
        print("execute() from CreatePostUseCase")
        return Observable<Bool>.create { emitter -> Disposable in
            emitter.onNext(true)
            return Disposables.create()
        }
        
//        print("execute() from CreatePostUseCase")
//        postRepository.createPost()
    }
}
