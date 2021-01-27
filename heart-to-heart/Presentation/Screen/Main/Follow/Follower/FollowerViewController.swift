import UIKit
import RxSwift
import RxCocoa
import XLPagerTabStrip
import Kingfisher

class FollowerViewController: UITableViewController, StoryboardInstantiable {
    
    static var storyboard: AppStoryboard = .follower
    
    private let disposeBase = DisposeBag()
    var viewModel: FollowerViewModel?
    
    let users = [
        DummyUser(nickname: "Sonny", imageUrl: "https://lh3.googleusercontent.com/proxy/xjIODs4CGSF2bDd3Jo8A8kIp6pm9kWt5FHaacETcTSA3rtyeEIQovYI10-oyHSTOydfTkovRsN48Cwz10XcmgvELUf63c_sqJ-z7-j0mBM0ocvxli7rK"),
        DummyUser(nickname: "Alex", imageUrl: "https://i.pinimg.com/originals/fe/74/fe/fe74fe34f8378c63409b88199b138da6.jpg"),
        DummyUser(nickname: "Blair", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAW_9mshAmBbMQBJis_yP0MD6u1a14_eOSEA&usqp=CAU"),
        DummyUser(nickname: "Blake", imageUrl: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/serena-gossip-girl-1588587514.jpg?crop=1.00xw:0.610xh;0,0.0467xh&resize=480:*"),
        DummyUser(nickname: "Blair", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAW_9mshAmBbMQBJis_yP0MD6u1a14_eOSEA&usqp=CAU")
    ]
    
    
    override func viewDidLoad() {
        self.tableView.register(UINib(nibName: "FollowerTableViewCell", bundle: nil), forCellReuseIdentifier: "follower_table_view_cell")
    }
}

extension FollowerViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = self.tableView.dequeueReusableCell(withIdentifier: "follower_table_view_cell", for: indexPath) as! FollowerTableViewCell
        let url = URL(string: users[indexPath.row].imageUrl)
        cell.imageViewAvatar.kf.setImage(with: url)
        cell.labelNickname.text = users[indexPath.row].nickname
        return cell
    }
}

extension FollowerViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Follower")
    }
}
