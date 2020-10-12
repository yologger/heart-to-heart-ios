import UIKit
import RxSwift
import RxCocoa

class CreatePostViewModel: BaseViewModel {
    
    let didCoordinatorChange = PublishSubject<HomeCoordinatorOptions>()
    
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
        self.didCoordinatorChange.onNext(.closeCreatePostVC)
    }
}
