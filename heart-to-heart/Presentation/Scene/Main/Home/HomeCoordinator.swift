import UIKit

class HomeCoordinator: BaseCoordinator {
    
    override func start() {
        let homeViewController = HomeViewController.instantiate()
        self.navigationController.viewControllers = [homeViewController]
    }
}
