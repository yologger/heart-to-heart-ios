import RxSwift
import UIKit

protocol PostRepository: BaseRepository {
    func createPost(content: String, images: [UIImage?]) -> Observable<Bool>
    func test() -> Observable<GetAllPostsResult>
    // func fetchAllMovies() -> Observable<Any>
    // func createPost(title: String, images: [UIImage?]) -> Observable<CreatePostResult>
}
