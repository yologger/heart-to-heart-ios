protocol AuthAPI: RemoteDataSource {
    func getSignUpService() -> SignUpService
    func getLogInService() -> LogInService
    func getLogOutService() -> LogOutService
}
