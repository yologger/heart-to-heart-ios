import UIKit

class AppCoordinator: BaseCoordinator {
    
    private var window = UIWindow(frame: UIScreen.main.bounds)
    private var isLoggedIn = true
    
    override func start() {
        isLoggedIn ? showMain() : showLogIn()
    }
    
    func showLogIn() {
        self.removeChildCoordinators()
        
        // DI 필요
        let signUpCoordinator = SignUpCoordinator()
        self.start(coordinator: signUpCoordinator)
        self.window.rootViewController = signUpCoordinator.viewController
        self.window.makeKeyAndVisible()
    }
    
    func showMain() {
        self.removeChildCoordinators()
        let mainCoordinator = MainCoordinator()
        self.start(coordinator: mainCoordinator)
        self.window.rootViewController = mainCoordinator.viewController
        self.window.makeKeyAndVisible()
    }
}
