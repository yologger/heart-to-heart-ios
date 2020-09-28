import UIKit
import RxSwift

enum HomeCoordinatorOptions {
    case showCreatePostVC
    case closeCreatePostVC
    case showSearchHistoryVC
    case closeSearchHistoryVC
}

class HomeCoordinator: BaseCoordinator {
    
    private let disposeBag = DisposeBag()
    
    private var homeViewController: HomeViewController?
    private var searchHistoryViewController: SearchHistoryViewController?
    private var createPostViewController: CreatePostViewController?
    
    private let homeViewModel: HomeViewModel
    private let createPostViewModel: CreatePostViewModel
    
    init(homeViewModel: HomeViewModel, createPostViewModel: CreatePostViewModel) {
        self.homeViewModel = homeViewModel
        self.createPostViewModel = createPostViewModel
    }
    
    override func start() {
        self.homeViewController = HomeViewController.instantiate()
        homeViewController!.viewModel = self.homeViewModel
        self.navigationController.viewControllers = [self.homeViewController!]
        
        self.bindToHomeViewModel()
    }
    
    func bindToHomeViewModel() {
        self.homeViewModel.didCoordinatorChange
        .subscribe(
            onNext: { value in
                switch value {
                case .showCreatePostVC: self.showCreatePost()
                case .closeCreatePostVC: self.closeCreatePost()
                case .showSearchHistoryVC: self.showSearchHistory()
                case .closeSearchHistoryVC: self.closeSearchHistory()
                }
            },
            onError: {error in print(error)},
            onCompleted: {print("onCompleted")},
            onDisposed: {print("onDisposed")}
        )
        .disposed(by: disposeBag)
    }
    
    private func showCreatePost() {
        print("showCreatePost()")
    }
    
    private func closeCreatePost() {
        print("closeCreatePost()")
    }
    
    private func showSearchHistory() {
        print("showSearchHistory()")
        self.searchHistoryViewController = SearchHistoryViewController.instantiate()
        
        guard let homeVC = self.homeViewController, let searchHistoryContainer = homeVC.searchHistoryContainer, let searchHistoryVC = self.searchHistoryViewController else {
            return
        }
    
        homeVC.add(child: searchHistoryVC, container: searchHistoryContainer)
        homeVC.searchHistoryContainer.isHidden = false
    }
    
    private func closeSearchHistory() {
        self.searchHistoryViewController?.remove()
        self.searchHistoryViewController = nil
        guard let homeVC = self.homeViewController else {
            return
        }
        homeVC.searchHistoryContainer.isHidden = true
    }
}

