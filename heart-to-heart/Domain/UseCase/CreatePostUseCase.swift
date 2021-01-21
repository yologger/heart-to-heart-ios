import RxSwift
import UIKit

final class CreatePostUseCase {
    
    private let _postRepository: PostRepository
    
    var content: String?
    var images: [UIImage?]?
    
    init(postRepository: PostRepository) {
        self._postRepository = postRepository
    }
}

extension CreatePostUseCase: BaseUseCase {
    
    func call() -> Observable<Bool> {
        
        print("CreatePostUseCase, content: \(content)")
        print("CreatePostUseCase, images: \(images)")
        
        return _postRepository.createPost(content: content!, images: images!)
        
        //        print("execute() from CreatePostUseCase")
        //        postRepository.createPost()
    }
}
