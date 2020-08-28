import UIKit

class SignUpCoordinator: BaseCoordinator {
    
    override func start() {
        let signUpViewController = SignUpViewController.instantiate()
        
        self.viewController = signUpViewController
    }
}
