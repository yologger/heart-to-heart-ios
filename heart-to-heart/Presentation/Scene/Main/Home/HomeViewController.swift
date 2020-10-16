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
    
    lazy var createPostButton: UIBarButtonItem = {
        
        let orignalImage = UIImage(named: "create_icon")
        let tintedImage = orignalImage?.withRenderingMode(.alwaysTemplate)

        let button = UIBarButtonItem(
            image: tintedImage,
            style: .plain,
            target: self,
            action: #selector(buttonPressed(_:))
        )
        
        button.tintColor = .black
        
        button.tag = 2
        
        
//        let button = UIBarButtonItem(
//            title: "Create",
//            style: .plain,
//            target: self,
//            action: #selector(buttonPressed(_:)))
//        button.tag = 2

        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.initTableView()
        self.initNavigation()
        self.initSearchBar()
        self.initBinding()
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        viewModel!.getAllPosts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear from HomeViewController")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear from HomeViewController")
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
    }
}


// MARK: - Navigation
extension HomeViewController {
    func initNavigation() {
        self.navigationItem.rightBarButtonItem = self.createPostButton
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
