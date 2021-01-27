import RxSwift

protocol SessionStorage: LocalDataSource {
    func setSession(session: UserSession)
    func removeSession()
    func updateTokens(tokens: Tokens)
    func getSessionState() -> Observable<Bool>
    func getCurrentSession() -> UserSession?
    func getAccessToken() -> String?
    func getRefreshToken() -> String?
    func getUserId() -> Int?
}
