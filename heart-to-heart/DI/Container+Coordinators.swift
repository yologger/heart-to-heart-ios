import Swinject
import SwinjectAutoregistration

extension Container {
    func registerCoordinators() {
        self.autoregister(AppCoordinator.self, initializer: AppCoordinator.init)
        self.autoregister(AuthorizationCoordinator.self, initializer: AuthorizationCoordinator.init)
        self.autoregister(MainCoordinator.self, initializer: MainCoordinator.init)
        self.autoregister(HomeCoordinator.self, initializer: HomeCoordinator.init)
        self.autoregister(FollowCoordinator.self, initializer: FollowCoordinator.init)
        self.autoregister(ProfileCoordinator.self, initializer: ProfileCoordinator.init)
    }
}
