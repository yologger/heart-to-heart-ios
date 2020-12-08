import RxSwift

protocol PostRepository: BaseRepository {
    func test() -> Observable<GetAllPostsResult >
    // func fetchAllMovies() -> Observable<Any>
    func createPost()
}
