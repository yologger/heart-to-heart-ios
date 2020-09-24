import UIKit
import RxSwift

class HomeCoordinator: BaseCoordinator {
    
    private let disposeBag = DisposeBag()
    
    private let createPostViewModel: CreatePostViewModel
    private let homeViewModel: HomeViewModel
    
    init(homeViewModel: HomeViewModel, createPostViewModel: CreatePostViewModel) {
        self.homeViewModel = homeViewModel
        self.createPostViewModel = createPostViewModel
    }
    
    override func start() {
        let homeViewController = HomeViewController.instantiate()
        homeViewController.viewModel = self.homeViewModel
        self.navigationController.viewControllers = [homeViewController]
        
        self.bindToHomeViewModel()
    }
    
    func bindToHomeViewModel() {
        self.homeViewModel.didCoordinatorChange
        .subscribe{ value in
            print("This is subscribe() from HomeCoordinator")
            print(value)
        }
        .disposed(by: disposeBag)
    }
    
    func bindToCreatePostViewModel() {
        
    }
    
    func showCreatePost() {
        
    }
}

enum HomeCoordinatorOptions {
    case startCreatePostVC
    case finishCreatePostVC
}
