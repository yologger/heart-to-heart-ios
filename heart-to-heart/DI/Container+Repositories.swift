import Swinject
import SwinjectAutoregistration

extension Container {
    func registerRepositories() {
        self.autoregister(SessionRepository.self, initializer: SessionRepository.init).inObjectScope(.container)
         self.autoregister(PostRepository.self, initializer: PostRepositoryImpl.init).inObjectScope(.container)
    }
}
