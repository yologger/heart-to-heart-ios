import Swinject
import SwinjectAutoregistration

extension Container {
    func registerDataSources() {
        self.autoregister(AuthAPI.self, initializer: DefaultAuthAPI.init).inObjectScope(.container)
        self.autoregister(PostAPI.self, initializer: DefaultPostAPI.init).inObjectScope(.container)
        self.autoregister(SessionStorage.self, initializer: DefaultSessionStorage.init).inObjectScope(.container)
    }
}
