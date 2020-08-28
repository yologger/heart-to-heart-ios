import UIKit

class ProfileCoordinator: BaseCoordinator {
    
    override func start() {
        let profileViewController = ProfileViewController.instantiate()
        
        self.viewController = profileViewController
    }
}
