import UIKit
import RxSwift
import RxCocoa

enum FollowCoordinatorOptions {
    case showFollowing
    case showFollower
}

class FollowCoordinator: BaseCoordinator {
    
    private let disposeBag = DisposeBag()
    
    private var followViewController: FollowViewController?
    private var followingViewController: FollowingViewController?
    private var followerViewController: FollowerViewController?
    
    private let followViewModel: FollowViewModel
    private let followingViewModel: FollowingViewModel
    private let followerViewModel: FollowerViewModel
    
    init(followViewModel: FollowViewModel, followingViewModel: FollowingViewModel, followerViewModel: FollowerViewModel) {
        self.followViewModel = followViewModel
        self.followingViewModel = followingViewModel
        self.followerViewModel = followerViewModel
    }
    
    override func start() {
        print("start() from FollowCoordinator")
        self.followViewController = FollowViewController.instantiate()
        self.followViewController!.viewModel = self.followViewModel
        // self.navigationController.isNavigationBarHidden = true
        self.navigationController.viewControllers = [self.followViewController!]
        
        self.bindToFollowViewModel()
    }
    
    private func bindToFollowViewModel() {
        self.followViewModel.didCoordinatorChange
        .subscribe(
            onNext: { value in
                switch value {
                case .showFollowing:
                    self.closeFollower()
                    self.showFollowing()
                    break
                case .showFollower:
                    self.closeFollowing()
                    self.showFollower()
                    break
                }
            },
            onError: { error in print(error) },
            onCompleted: { print("onCompleted") },
            onDisposed: { print("onDisposed") }
        )
        .disposed(by: disposeBag)
    }
    
    func showFollowing() {
        let uiStoryBoard = UIStoryboard(name: "Following", bundle: nil)
        self.followingViewController = uiStoryBoard.instantiateViewController(withIdentifier: "FollowingViewController") as? FollowingViewController
        guard let followVC = self.followViewController, let followingVC = self.followingViewController, let containerView = followVC.containerView
        else { return }

        followVC.add(child: followingVC, container: containerView)
    }
    
    func closeFollowing() {
        self.followingViewController?.remove()
        self.followingViewController = nil
    }
    
    func showFollower() {
        let uiStoryBoard = UIStoryboard(name: "Follower", bundle: nil)
        self.followerViewController = uiStoryBoard.instantiateViewController(withIdentifier: "FollowerViewController") as? FollowerViewController
        guard let followVC = self.followViewController, let followerVC = self.followerViewController, let containerView = followVC.containerView
        else { return }

        followVC.add(child: followerVC, container: containerView)
    }
    
    func closeFollower() {
        self.followerViewController?.remove()
        self.followerViewController = nil
    }
}
