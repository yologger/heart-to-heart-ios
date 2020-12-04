import Swinject
import SwinjectAutoregistration

extension Container {
    func registerRepositories() {
        self.autoregister(SessionRepository.self, initializer: DefaultSessionRepository.init).inObjectScope(.container)
        self.autoregister(PostRepository.self, initializer: DefaultPostRepository.init).inObjectScope(.container)
    }
}
