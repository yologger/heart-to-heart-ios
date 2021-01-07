import UIKit
import RxSwift
import RxCocoa

class PostListViewModel: BaseViewModel {

    let didCoordinatorChange = PublishSubject<HomeCoordinatorOptions>()
    
    private let getAllPostsUseCase: GetAllPostsUseCase
    
    init(getAllPostsUseCase: GetAllPostsUseCase) {
        self.getAllPostsUseCase = getAllPostsUseCase
    }
    
    func test() {
        // print("test() from PostListViewModel")
    }
    
    func getAllPost() {
        getAllPostsUseCase.execute()
    }
}
