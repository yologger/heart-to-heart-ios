import UIKit

class MainCoordinator: BaseCoordinator {
    
    private let homeCoordinator: HomeCoordinator
    private let followCoordinator: FollowCoordinator
    private let profileCoordinator: ProfileCoordinator
    
    init(homeCoordinator: HomeCoordinator, followCoordinator: FollowCoordinator, profileCoordinator: ProfileCoordinator) {
        self.homeCoordinator = homeCoordinator
        self.followCoordinator = followCoordinator
        self.profileCoordinator = profileCoordinator
    }
    
    
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
        self.start(coordinator: self.homeCoordinator)
        let homeViewController: UINavigationController = self.homeCoordinator.navigationController
        let title = "Home"
        let image = UIImage(named: "home_icon.png")
        let selectedImage = UIImage(named: "home_icon.png")
        let tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        homeViewController.tabBarItem = tabBarItem
        return homeViewController
    }
    
    private func getFollowViewController() -> UINavigationController {
        self.start(coordinator: self.followCoordinator)
        let followViewController: UINavigationController = self.followCoordinator.navigationController
        let title = "Follow"
        let image = UIImage(named: "follow_icon.png")
        let selectedImage = UIImage(named: "follow_icon.png")
        let tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        followViewController.tabBarItem = tabBarItem
        return followViewController
    }
    
    private func getProfileViewController() -> UINavigationController {
        self.start(coordinator: self.profileCoordinator)
        let profileViewController: UINavigationController = self.profileCoordinator.navigationController
        let title = "Profile"
        let image = UIImage(named: "profile_icon.png")
        let selectedImage = UIImage(named: "profile_icon.png")
        let tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        profileViewController.tabBarItem = tabBarItem
        return profileViewController
    }
    
}
