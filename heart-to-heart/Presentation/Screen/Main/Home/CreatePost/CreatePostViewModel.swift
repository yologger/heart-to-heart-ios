import UIKit
import RxSwift
import RxCocoa
import TLPhotoPicker

class CreatePostViewModel: BaseViewModel {
    
    let didCoordinatorChange = PublishSubject<HomeCoordinatorOptions>()
    
    private let createPostUseCase: CreatePostUseCase
    
    let isLoading = BehaviorSubject<Bool>(value: false)
    let content = BehaviorSubject<String>(value: "")
    
    var selectedTLPHAssets: [TLPHAsset] = []
    let selectedTLPHAssetsObservable = BehaviorSubject<[TLPHAsset]>(value: [])
    
    init(createPostUseCase: CreatePostUseCase) {
        self.createPostUseCase = createPostUseCase
    }
    
    
    func addTLPHAssets(assets: [TLPHAsset]) {
        selectedTLPHAssets.append(contentsOf: assets)
        selectedTLPHAssetsObservable.onNext(selectedTLPHAssets)
    }
    
    func closeCreatePost() {
        self.didCoordinatorChange.onNext(.closeCreatePostVC)
    }
    
    func clear() {
        selectedTLPHAssets = []
        selectedTLPHAssetsObservable.onNext(selectedTLPHAssets)
    }
    
    func showGallery() {
        // self.didCoordinatorChange.onNext(.closeCreatePostVC)
    }
    
    func createPost() {
        
        Observable
            .combineLatest(self.content, self.selectedTLPHAssetsObservable)
            .take(1)
            .do { [weak self] content, selectedTLPHAssets in
                self?.createPostUseCase.content = content
                self?.createPostUseCase.assets = selectedTLPHAssets
            }
            .flatMap { [weak self] content, selectedTLPHAssets in
                self?.createPostUseCase.execute() ?? Observable.empty()
            }
            .subscribe(onNext: { (result) in
                switch result {
                case .success(let data):
                    print("post: \(data.post)")
                case .failure(let error):
                    switch error {
                    case .NetworkTimeOutError:
                        print("NetworkTimeOutError")
                    case .UnknownError:
                        print("NetworkTimeOutError")
                    }
                }
                
            }, onError: { (error) in
                
            }, onCompleted: {
                
            }, onDisposed: {
                
            })
            .disposed(by: self.disposeBag)
        
        
        
        
        //            .subscribe { content, selectedImages in
        //                print("content: \(content)")
        //                print("selectedImages:")
        //                print(selectedImages)
        //            }
        //            .disposed(by: self.disposeBag)
        
        //         print(images)
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
    
    deinit {
        print("deinit")
    }
}
