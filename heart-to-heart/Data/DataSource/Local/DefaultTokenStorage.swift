final class DefaultTokenStorage {
    
    private let keyChainService: KeyChainService
    init(keyChainService: KeyChainService) {
        self.keyChainService = keyChainService
    }
}

extension DefaultTokenStorage: TokenStorage {
    
    func test() {
        print("test() from DefaultTokenStorage")
    }
    
    func getAccessToken() -> AccessToken? {
        let accessToken = keyChainService.load(key: SettingKey.accessToken)
        if accessToken == nil {
            return nil
        } else {
            return AccessToken(accessToken: accessToken)
        }
    }
    
    func getRefreshToken() -> RefreshToken? {
        let refreshToken = keyChainService.load(key: SettingKey.refreshToken)
        if refreshToken == nil {
            return nil
        } else {
            return RefreshToken(refreshToken: refreshToken)
        }
    }
    
    func setAccessToken(accessToken: String) throws {
        self.keyChainService.save(key: SettingKey.accessToken, value: accessToken)
    }
    
    func setRefreshToken(refreshToken: String) throws {
        self.keyChainService.save(key: SettingKey.refreshToken, value: refreshToken)
    }
}
