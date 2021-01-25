import UIKit
import RxSwift
import RxCocoa
import XLPagerTabStrip

class FollowerViewController: UITableViewController, StoryboardInstantiable {
    
    static var storyboard: AppStoryboard = .follower
    
    private let disposeBase = DisposeBag()
    var viewModel: FollowerViewModel?
    
    override func viewDidLoad() {
        self.tableView.register(UINib(nibName: "FollowerTableViewCell", bundle: nil), forCellReuseIdentifier: "follower_table_view_cell")
    }
}

extension FollowerViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let followerTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "follower_table_view_cell", for: indexPath)
        return followerTableViewCell
    }
}

extension FollowerViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Follower")
    }
}
