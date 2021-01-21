import UIKit
import RxSwift

enum HomeCoordinatorOptions {
    case showPostListVC
    case closePostListVC
    case showCreatePostVC
    case closeCreatePostVC
    case showSearchHistoryVC
    case closeSearchHistoryVC
}

class HomeCoordinator: BaseCoordinator {
    
    private let disposeBag = DisposeBag()
    
    private var homeViewController: HomeViewController?
    private var postListViewController: PostListViewController?
    private var searchHistoryViewController: SearchHistoryViewController?
    private var createPostViewController: CreatePostViewController?
    
    private let homeViewModel: HomeViewModel
    private let postListViewModel: PostListViewModel
    private let createPostViewModel: CreatePostViewModel
    private let searchHistoryViewModel: SearchHistoryViewModel
    
    init(homeViewModel: HomeViewModel, postListViewModel: PostListViewModel, createPostViewModel: CreatePostViewModel, searchHistoryViewModel: SearchHistoryViewModel) {
        self.homeViewModel = homeViewModel
        self.postListViewModel = postListViewModel
        self.createPostViewModel = createPostViewModel
        self.searchHistoryViewModel = searchHistoryViewModel
    }
    
    override func start() {
        
        //        self.testViewController = TestViewController.instantiate()
        //        self.testViewController!.viewModel = self.testViewModel
        //        self.navigationController.viewControllers = [self.testViewController!]
        
        self.homeViewController = HomeViewController.instantiate()
        self.homeViewController!.viewModel = self.homeViewModel
        self.navigationController.viewControllers = [self.homeViewController!]
        
        self.bindToHomeViewModel()
        self.bindToCreatePostViewModel()
    }
    
    private func showPostList() {
        self.postListViewController = PostListViewController.instantiate()
        
        guard let homeVC = self.homeViewController, let postListContainer = homeVC.postListContainer, let postListVC = self.postListViewController else {
            return
        }
        
        postListVC.viewModel = self.postListViewModel
        
        homeVC.add(child: postListVC, container: postListContainer)
    }
    
    private func closePostList() {
        self.postListViewController?.remove()
        self.postListViewController = nil
    }
    
    private func showSearchHistory() {
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
        guard let homeVC = self.homeViewController else { return }
        homeVC.searchHistoryContainer.isHidden = true
    }
    
    
    func bindToHomeViewModel() {
        self.homeViewModel.didCoordinatorChange
            .subscribe(
                onNext: { value in
                    switch value {
                    case .showPostListVC: self.showPostList()
                    case .closePostListVC: self.closePostList()
                    case .showCreatePostVC: self.showCreatePost()
                    case .closeCreatePostVC: self.closeCreatePost()
                    case .showSearchHistoryVC: self.showSearchHistory()
                    case .closeSearchHistoryVC: self.closeSearchHistory()
                    }
                },
                onError: { error in print(error) },
                onCompleted: { print("onCompleted") },
                onDisposed: { print("onDisposed") }
            )
            .disposed(by: disposeBag)
    }
    
    func bindToCreatePostViewModel() {
        self.createPostViewModel.didCoordinatorChange
            .subscribe(
                onNext: { value in
                    switch value {
                    case .showPostListVC: self.showPostList()
                    case .closePostListVC: self.closePostList()
                    case .showCreatePostVC: self.showCreatePost()
                    case .closeCreatePostVC: self.closeCreatePost()
                    case .showSearchHistoryVC: self.showSearchHistory()
                    case .closeSearchHistoryVC: self.closeSearchHistory()
                    }
                },
                onError: { error in print(error) },
                onCompleted: { print("onCompleted") },
                onDisposed: { print("onDisposed") }
            )
            .disposed(by: disposeBag)
    }
    
    private func showCreatePost() {
        var createPostViewController = CreatePostViewController.instantiate()
        
        createPostViewController.viewModel = createPostViewModel
        // createPostViewController.modalPresentationStyle = .fullScreen
        self.navigationController.present(createPostViewController, animated: true, completion: nil)
        // self.navigationController.pushViewController(createPostViewController, animated: true)
    }
    
    private func closeCreatePost() {
        self.navigationController.dismiss(animated: true, completion: nil) 
        // self.navigationController.popViewController(animated: true)
    }

}

