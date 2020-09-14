import UIKit

class MainCoordinator: BaseCoordinator {
    
    override func start() {
        self.navigationController.isNavigationBarHidden = true
        let mainViewController = MainViewController.instantiate()

        mainViewController.setViewControllers([
            getHomeViewController(),
            getFollowViewController(),
            getProfileViewController()
        ], animated: true)
                
        self.navigationController.viewControllers = [mainViewController]
    }
    
    private func getHomeViewController() -> UINavigationController {
        let homeCoordinator = HomeCoordinator()
        self.start(coordinator: homeCoordinator)
        let homeViewController: UINavigationController = homeCoordinator.navigationController
        let title = "Home"
        let image = UIImage(named: "home_icon.png")
        let selectedImage = UIImage(named: "home_icon.png")
        let tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        homeViewController.tabBarItem = tabBarItem
        return homeViewController
    }
    
    private func getFollowViewController() -> UINavigationController {
        let followCoordinator = FollowCoordinator()
        self.start(coordinator: followCoordinator)
        let followViewController: UINavigationController = followCoordinator.navigationController
        let title = "Follow"
        let image = UIImage(named: "follow_icon.png")
        let selectedImage = UIImage(named: "follow_icon.png")
        let tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        followViewController.tabBarItem = tabBarItem
        return followViewController
    }
    
    private func getProfileViewController() -> UINavigationController {
        let profileCoordinator = ProfileCoordinator()
        self.start(coordinator: profileCoordinator)
        let profileViewController: UINavigationController = profileCoordinator.navigationController
        let title = "Profile"
        let image = UIImage(named: "profile_icon.png")
        let selectedImage = UIImage(named: "profile_icon.png")
        let tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        profileViewController.tabBarItem = tabBarItem
        return profileViewController
    }
    
}
