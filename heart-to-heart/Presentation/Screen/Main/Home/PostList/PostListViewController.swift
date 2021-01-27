import UIKit
import RxSwift
import RxCocoa

class PostListViewController: BaseTableViewController, StoryboardInstantiable {
    
    static var storyboard: AppStoryboard = .postList
    
    var viewModel: PostListViewModel?
    
    private var isLoading = false
    
    override func viewDidLoad() {
        self.tableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "PostTableViewCell")
        self.tableView.register(UINib(nibName: "LoadingCell", bundle: nil), forCellReuseIdentifier: "LoadingCell")
        
        self.tableView.separatorStyle = .singleLine
        
        self.setupBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.getPosts()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
        viewModel?.clear()
    }
    
    private func setupBinding() {
        guard let _viewModel = self.viewModel else { return }
        _viewModel.postsObservable.asObservable().subscribe(onNext: { [weak self] (posts) in
            self?.tableView.reloadData()
        }, onError: { (error) in
            
        }, onCompleted: {
            
        }, onDisposed: {
            
        }
        ).disposed(by: self.disposeBag)
        
        self.bindTableView()
    }
    
    private func bindTableView() {

        guard let _viewModel = self.viewModel else { return }
        
    }
}

extension PostListViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let _viewModel = self.viewModel else { return 0 }
        
        if section == 0 {
            // return contents.count
            return _viewModel.posts.count
        } else if section == 1 {
            return 1
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
            cell.labelContent.text = viewModel?.posts[indexPath.row].content
            cell.labelNickname.text = viewModel?.posts[indexPath.row].user?.nickname!
            
            let imageUrl = viewModel?.posts[indexPath.row].user?.url
            if (imageUrl != nil) {
                let url = URL(string: "\(Constant.API.AuthBaseUrl)/\(imageUrl!)")
                cell.imageViewAvatar.kf.setImage(with: url)
            }
            
            let dateString = viewModel!.posts[indexPath.row].createdAt!
            var dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
            let date = dateFormatter.date(from: dateString)!
            dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.timeStyle = .full
            dateFormatter.dateFormat = "MMMM d, eee"
            cell.labelCreatedAt.text = "\(dateFormatter.string(from: date))"
            
            let images = viewModel?.posts[indexPath.row].postImages
            cell.updateImageSet(images: images)
            
            
            return cell
        } else {
            let loadingCell = self.tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath) as! LoadingCell
            loadingCell.activityIndicatorViewLoading.startAnimating()
            return loadingCell
        }
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        guard let _viewModel = self.viewModel else { return }
        
        if (offsetY > contentHeight - scrollView.frame.height) && !_viewModel.isLoading {
            fetchMorePosts()
        }
    }

    private func fetchMorePosts() {
        print("fetchMorePosts()")
        viewModel?.getPosts()
//        if !self.isLoading {
//            self.isLoading = true
//            DispatchQueue.global().async {
//                // Fake background loading task for 2 seconds
//                sleep(10)
//                // Download more data here
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                    self.isLoading = false
//                }
//            }
//        }
    }
    
//    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offsetY = scrollView.contentOffset.y
//        let contentHeight = scrollView.contentSize.height
//
//        if (offsetY > contentHeight - scrollView.frame.height - 100) && !isLoading {
//            fetchMorePosts()
//        }
//    }
    
//    private func fetchMorePosts() {
//        if !self.isLoading {
//            self.isLoading = true
//            DispatchQueue.global().async {
//                // Fake background loading task for 2 seconds
//                sleep(10)
//                // Download more data here
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                    self.isLoading = false
//                }
//            }
//        }
//    }
}
