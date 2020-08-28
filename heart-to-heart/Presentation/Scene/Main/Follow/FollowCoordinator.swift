import UIKit

class FollowCoordinator: BaseCoordinator {
    
    override func start() {
        let followViewController = FollowViewController.instantiate()
        
        self.viewController = followViewController
    }
}
