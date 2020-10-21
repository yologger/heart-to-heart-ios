import Swinject
import SwinjectAutoregistration

extension Container {
    func registerDataSources() {
        self.autoregister(AuthorizationApi.self, initializer: AuthorizationApiImpl.init).inObjectScope(.container)
    }
}
