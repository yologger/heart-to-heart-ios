import UIKit

class MainCoordinator: BaseCoordinator {
    
    override func start() {
        let mainViewController = MainViewController.instantiate()
        
        let homeCoordinator = HomeCoordinator()
        self.start(coordinator: homeCoordinator)
        let homeViewController = homeCoordinator.viewController
        
        let followCoordinator = FollowCoordinator()
        self.start(coordinator: followCoordinator)
        let followViewController = followCoordinator.viewController

        let profileCoordinator = ProfileCoordinator()
        self.start(coordinator: profileCoordinator)
        let profileViewController = profileCoordinator.viewController

        mainViewController.setViewControllers([homeViewController!, followViewController!, profileViewController!], animated: true)
                
        self.viewController = mainViewController
    }
}
