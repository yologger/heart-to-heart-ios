import RxSwift
import UIKit
import TLPhotoPicker

final class CreatePostUseCase {
    
    private let _postRepository: PostRepository
    
    var content: String?
    var assets: [TLPHAsset]?
    
    init(postRepository: PostRepository) {
        self._postRepository = postRepository
    }
}

extension CreatePostUseCase: BaseUseCase {
    
    func call() -> Observable<CreatePostResult> {
        return _postRepository.createPost(content: content, assets: assets)
    }
}
