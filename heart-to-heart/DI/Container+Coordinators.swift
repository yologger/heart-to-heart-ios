import Swinject
import SwinjectAutoregistration

extension Container {
    func registerCoordinators() {
        self.autoregister(AppCoordinator.self, initializer: AppCoordinator.init)
        self.autoregister(AuthorizationCoordinator.self, initializer: AuthorizationCoordinator.init)
    }
}
