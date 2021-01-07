import RxSwift
import UIKit

final class CreatePostUseCase {
    
    private let _postRepository: PostRepository
    
    private var _text: String?
    private var _images: [UIImage?]?
    
    init(postRepository: PostRepository) {
        self._postRepository = postRepository
    }
}

extension CreatePostUseCase: BaseUseCase {
    
    func call() -> Observable<Bool> {
        
        return Observable<Bool>.create { [weak self] emitter -> Disposable in
            
            emitter.onNext(true)
            return Disposables.create()
        }
        
        //        print("execute() from CreatePostUseCase")
        //        postRepository.createPost()
    }
}
