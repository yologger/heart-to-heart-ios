import UIKit

class AppCoordinator: BaseCoordinator {
    
    private var window = UIWindow(frame: UIScreen.main.bounds)
    private var isLoggedIn = false
    
    override func start() {
        isLoggedIn ? showMain() : showAuthorization()
    }
    
    func showAuthorization() {
        self.removeChildCoordinators()
        
        // DI 필요
        
        // DI 필요
        let authorizationCoordinator = AppDelegate.container.resolve(AuthorizationCoordinator.self)!
        // let authorizationCoordinator = AuthorizationCoordinator()
        self.start(coordinator: authorizationCoordinator)
        self.window.rootViewController = authorizationCoordinator.navigationController
        self.window.makeKeyAndVisible()
    }
    
    func showMain() {
        self.removeChildCoordinators()
        
        let mainCoordinator = MainCoordinator()
        self.start(coordinator: mainCoordinator)
        self.window.rootViewController = mainCoordinator.navigationController
        self.window.makeKeyAndVisible()
    }
    
    func subscribeSessionChange() {
        
    }
}
