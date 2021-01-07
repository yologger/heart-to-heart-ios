import RxSwift
import UIKit

protocol PostRepository: BaseRepository {
    func test() -> Observable<GetAllPostsResult>
    // func fetchAllMovies() -> Observable<Any>
    // func createPost(title: String, images: [UIImage?]) -> Observable<CreatePostResult>
}
