import Foundation
import RxSwift

final class DefaultSessionStorage {
    
    private var _session: UserSession?
    
    lazy private var _sessionState: BehaviorSubject<Bool> = {
        loadSession()
        if(_session == nil) {
            return BehaviorSubject<Bool>(value: false)
        } else {
            return BehaviorSubject<Bool>(value: true)
        }
    }()

    private func loadSession() {
        let userDefaults = UserDefaults.standard
        do {
            print("success")
            let session = try userDefaults.getObject(forKey: Constant.Key.SessionKey, castTo: UserSession.self)
            _session = session
            _sessionState = BehaviorSubject<Bool>(value: true)
        } catch {
            print(error.localizedDescription)
            print("fail")
            _session = nil
            _sessionState = BehaviorSubject<Bool>(value: false)
        }
    }
}

extension DefaultSessionStorage: SessionStorage {
    
    func getCurrentSession() -> UserSession? {
        return _session
    }

    func getAccessToken() -> String? {
        return _session?.tokens.accessToken
    }
    
    func getRefreshToken() -> String? {
        return _session?.tokens.refreshToken
    }
    
    
    func getSessionState() -> Observable<Bool> {
        return _sessionState.asObservable()
    }
    
    func setSession(session: UserSession) {
        let userDefaults = UserDefaults.standard
        do {
            try userDefaults.setObject(session, forKey: Constant.Key.SessionKey)
            userDefaults.synchronize()
            _session = session
            _sessionState.onNext(true)
        } catch {
            print(error.localizedDescription)
            _session = nil
            _sessionState.onNext(false)
        }
    }
    
    func removeSession() {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: Constant.Key.SessionKey)
        userDefaults.synchronize()
        _session = nil
        _sessionState.onNext(false)
    }
    
    func updateTokens(tokens: Tokens) {
        guard let email = _session?.email, let profile = _session?.profile else {
            return
        }
        
        let newSession = UserSession(
            email: email,
            profile: profile,
            tokens: tokens
        )
        let userDefaults = UserDefaults.standard
        do {
            try userDefaults.setObject(newSession, forKey: Constant.Key.SessionKey)
            userDefaults.synchronize()
            _session = newSession
            
        } catch {
            print(error.localizedDescription)
            _session = nil
        }
    }
    
    func getUserId() -> Int? {
        let userId = _session?.profile.userId
        return userId
    }
}
