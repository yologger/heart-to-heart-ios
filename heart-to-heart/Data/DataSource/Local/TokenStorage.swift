protocol TokenStorage {
    func test()
    func getAccessToken() -> AccessToken?
    func getRefreshToken() -> RefreshToken?
    func setAccessToken(accessToken: String) throws
    func setRefreshToken(refreshToken: String) throws
}
