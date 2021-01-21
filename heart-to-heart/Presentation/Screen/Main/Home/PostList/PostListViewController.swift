import UIKit
import RxSwift
import RxCocoa

class PostListViewController: BaseTableViewController, StoryboardInstantiable {
    
    static var storyboard: AppStoryboard = .postList
    
    private let disposeBag = DisposeBag()
    var viewModel: PostListViewModel?
    
    override func viewDidLoad() {
        self.tableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "post_table_view_cell")
        viewModel?.test()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "post_table_view_cell", for: indexPath) as! PostTableViewCell
        postTableViewCell.contextTextViewHeight.constant = postTableViewCell.contentTextView.contentSize.height
        return postTableViewCell
    }
}
