import RxSwift

final class PostRepositoryImpl {
    // private let cache: LocalPostDataSource
//    private let api: RemoteDataSource
//
//    init(api: RemoteDataSource) {
//        self.api = api
//    }
}

extension PostRepositoryImpl: PostRepository {
    
    func test() {
        print("test() from PostRepositoryImpl")
//        api.test()
    }
    
//    func fetchAllMovies() -> Observable<Any> {
//        
//    }
    

}
