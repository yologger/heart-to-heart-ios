import UIKit
import RxSwift
import RxCocoa

class FollowingViewController: UITableViewController, StoryboardInstantiable {
    
    static var storyboard: AppStoryboard = .following
    
    override func viewDidLoad() {
        view.backgroundColor = AppColor.Orange.normal
        self.tableView.register(UINib(nibName: "FollowingTableViewCell", bundle: nil), forCellReuseIdentifier: "following_table_view_cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let followingTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "following_table_view_cell", for: indexPath)
        return followingTableViewCell
    }
}
