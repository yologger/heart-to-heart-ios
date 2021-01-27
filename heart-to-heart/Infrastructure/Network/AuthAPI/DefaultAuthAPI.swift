final class DefaultAuthAPI {
    
    let authInterceptor: AuthInterceptor
    let sessionStorage: SessionStorage
    
    let signUpService: SignUpService
    let logInService: LogInService
    let logOutService: LogOutService
    let updateAvatarImageService: UpdateAvatarImageService
    
    init(authInterceptor: AuthInterceptor, sessionStorage: SessionStorage, signUpService: SignUpService, logInService: LogInService, logOutService: LogOutService, updateAvatarImageService: UpdateAvatarImageService) {
        self.authInterceptor = authInterceptor
        self.sessionStorage = sessionStorage
        self.signUpService = signUpService
        self.logInService = logInService
        self.logOutService = logOutService
        self.updateAvatarImageService = updateAvatarImageService
    }
}

extension DefaultAuthAPI: AuthAPI {
    func getSignUpService() -> SignUpService {
        return self.signUpService
    }
    
    func getLogInService() -> LogInService {
        return self.logInService
    }
    
    func getLogOutService() -> LogOutService {
        return self.logOutService
    }
    
    func getUpdateAvatarImageService() -> UpdateAvatarImageService {
        return self.updateAvatarImageService
    }
}
