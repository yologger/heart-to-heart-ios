import Swinject
import SwinjectAutoregistration

extension Container {
    func registerRepositories() {
        self.autoregister(SessionRepository.self, initializer: SessionRepository.init).inObjectScope(.container)
    }
}
