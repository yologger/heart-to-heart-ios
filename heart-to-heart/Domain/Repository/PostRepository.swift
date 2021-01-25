import RxSwift
import UIKit
import TLPhotoPicker

protocol PostRepository: BaseRepository {
    func createPost(content: String?, assets: [TLPHAsset]?) -> Observable<CreatePostResult>
    func test() -> Observable<GetAllPostsResult>
    // func fetchAllMovies() -> Observable<Any>
    // func createPost(title: String, images: [UIImage?]) -> Observable<CreatePostResult>
}
