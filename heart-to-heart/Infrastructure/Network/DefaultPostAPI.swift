final class DefaultPostAPI {
    let authInterceptor: AuthInterceptor
    
    init(authInterceptor: AuthInterceptor) {
        self.authInterceptor = authInterceptor
    }
}

extension DefaultPostAPI: PostAPI {
    func getPostService() -> PostService {
        return PostService(authInterceptor: authInterceptor)
    }
}
