import UIKit
import RxSwift
import RxCocoa

class CreatePostViewModel: BaseViewModel {
    
    let didCoordinatorChange = PublishSubject<HomeCoordinatorOptions>()
    
    private let createPostUseCase: CreatePostUseCase
    
    let isLoading = BehaviorSubject<Bool>(value: false)
    let content = BehaviorSubject<String>(value: "")
    
    init(createPostUseCase: CreatePostUseCase) {
        self.createPostUseCase = createPostUseCase
    }
    
    func closeCreatePost() {
        print("closeCreatePost() from CreatePostViewModel")
        // self.didCoordinatorChange.onNext(.closeCreatePostVC)
    }
    
    func showCamera() {
        print("showCamera() from CreatePostViewModel")
        // self.didCoordinatorChange.onNext(.closeCreatePostVC)
    }
    
    func showGallery() {
        print("showGallery() from CreatePostViewModel")
        // self.didCoordinatorChange.onNext(.closeCreatePostVC)
    }
    
    func createPost() {
//        self.isLoading.onNext(true)
//        self.content
//            .take(1)
//            .flatMapLatest { [weak self] text in
//                self?.createPostUseCase.execute() ?? Observable.empty()
//            }
//            .subscribe(
//                onNext: { [weak self] value in
//                    self?.isLoading.onNext(false)
//                    print(value)
//                }, onError: { error in
//
//                }, onCompleted: {
//                    print("onCompleted")
//                }, onDisposed: {
//                    print("onDisposed")
//                }
//            ).disposed(by: disposeBag)
        
        // self.createPostUseCase.execute()
        // self.didCoordinatorChange.onNext(.closeCreatePostVC)
    }
}
