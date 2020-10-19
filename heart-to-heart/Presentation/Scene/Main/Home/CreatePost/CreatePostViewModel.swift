import UIKit
import RxSwift
import RxCocoa

class CreatePostViewModel: BaseViewModel {
    
    let didCoordinatorChange = PublishSubject<HomeCoordinatorOptions>()
    
    private let createPostUseCase: CreatePostUseCase
    
    private var name: String = "Ronaldo"
    private var age: Int = 5
    
    
    init(createPostUseCase: CreatePostUseCase) {
        self.createPostUseCase = createPostUseCase
    }
    
    func closeCreatePost() {
        self.didCoordinatorChange.onNext(.closeCreatePostVC)
    }
    
    func showCamera() {
        self.didCoordinatorChange.onNext(.closeCreatePostVC)
    }
    
    func showAlbum() {
        self.didCoordinatorChange.onNext(.closeCreatePostVC)
    }
    
    func createPost() {
        print("createPost() from CreatePostViewModel")
        self.createPostUseCase.execute()
        // self.didCoordinatorChange.onNext(.closeCreatePostVC)
    }
}
