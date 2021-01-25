import UIKit
import RxSwift
import RxCocoa
import XLPagerTabStrip

class FollowingViewController: UITableViewController, StoryboardInstantiable {
    
    static var storyboard: AppStoryboard = .following
    
    override func viewDidLoad() {
        self.tableView.register(UINib(nibName: "FollowingTableViewCell", bundle: nil), forCellReuseIdentifier: "following_table_view_cell")
    }
}

extension FollowingViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let followingTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "following_table_view_cell", for: indexPath)
        return followingTableViewCell
    }
}

extension FollowingViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Following")
    }
}
