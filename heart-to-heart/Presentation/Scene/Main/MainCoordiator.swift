import UIKit

class MainCoordinator: BaseCoordinator {
    
    override func start() {
        self.navigationController.isNavigationBarHidden = true
        let mainViewController = MainViewController.instantiate()
        
        let homeCoordinator = HomeCoordinator()
        self.start(coordinator: homeCoordinator)
        let homeViewController: UINavigationController = homeCoordinator.navigationController

        let followCoordinator = FollowCoordinator()
        self.start(coordinator: followCoordinator)
        let followViewController: UINavigationController = followCoordinator.navigationController

        let profileCoordinator = ProfileCoordinator()
        self.start(coordinator: profileCoordinator)
        let profileViewController: UINavigationController = profileCoordinator.navigationController

        mainViewController.setViewControllers([homeViewController, followViewController, profileViewController], animated: true)
                
        self.navigationController.viewControllers = [mainViewController]
    }
}
