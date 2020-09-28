import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController, StoryboardInstantiable {
 
    static var storyboard = AppStoryboard.home
    
    private let disposeBag = DisposeBag()
    var viewModel: HomeViewModel?
    
    @IBOutlet weak var postListContainer: UIView!
    @IBOutlet weak var searchHistoryContainer: UIView!
    
    private var searchController = UISearchController(searchResultsController: nil)
    
    lazy var rightButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            title: "RightBtn",
            style: .plain,
            target: self,
            action: #selector(buttonPressed(_:)))
        button.tag = 2
        return button
        
    }()

    let behaviorSubject = BehaviorSubject<Int>(value: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.initTableView()
        self.initNavigation()
        self.initSearchBar()
        self.initBinding()
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
    }
    
    @objc private func buttonPressed(_ sender: Any) {
        if let button = sender as? UIBarButtonItem {
            switch button.tag {
            case 2:
                self.viewModel?.createPost()
            default:
                print("Button Error")
            }
        }
    }
    
    private func toggleSearchHistoryVisibility() {
        guard searchController.searchBar.isFirstResponder else {
            self.viewModel?.closeSearchHistory()
            return
        }
        self.viewModel?.showSearchHistory()
    }
}

// MARK: - Binding
extension HomeViewController {
    func initBinding() {
        behaviorSubject.subscribe{ value in print(value)}.disposed(by: disposeBag)
    }
}


// MARK: - Navigation
extension HomeViewController {
    func initNavigation() {
        self.navigationItem.rightBarButtonItem = self.rightButton
    }
}


// MARK: - Search Bar
extension HomeViewController: UISearchControllerDelegate {
    
    func initSearchBar() {
        searchController.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController = searchController
    }
    
    func willPresentSearchController(_ searchController: UISearchController) {
        self.toggleSearchHistoryVisibility()
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        self.toggleSearchHistoryVisibility()
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        self.toggleSearchHistoryVisibility()
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let text = searchController.searchBar.text else {
            return
        }
        print("Result: \(text)")
    }
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        print("Current value: \(text)")
    }
}


// MARK: - TableView
//extension HomeViewController: UITableViewDataSource {
//
//    func initTableView() {
//        self.tableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "post_table_view_cell")
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let postTableViewCell = tableView.dequeueReusableCell(withIdentifier: "post_table_view_cell", for: indexPath) as! PostTableViewCell
//        return postTableViewCell
//    }
//}
