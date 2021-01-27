import UIKit
import RxSwift
import RxCocoa
import XLPagerTabStrip
import Kingfisher

class FollowingViewController: UITableViewController, StoryboardInstantiable {
    
    static var storyboard: AppStoryboard = .following
    
    override func viewDidLoad() {
        self.tableView.register(UINib(nibName: "FollowingTableViewCell", bundle: nil), forCellReuseIdentifier: "following_table_view_cell")
    }

    let users = [
        DummyUser(nickname: "CR7", imageUrl: "https://thumbor.forbes.com/thumbor/fit-in/416x416/filters%3Aformat%28jpg%29/https%3A%2F%2Fspecials-images.forbesimg.com%2Fimageserve%2F5ec593cc431fb70007482137%2F0x0.jpg%3Fbackground%3D000000%26cropX1%3D1321%26cropX2%3D3300%26cropY1%3D114%26cropY2%3D2093"),
        DummyUser(nickname: "Sonny", imageUrl: "https://i.guim.co.uk/img/media/efc28f67969513ed59fd48ba1a74662ce2a66b6d/0_214_4154_2492/master/4154.jpg?width=1200&height=900&quality=85&auto=format&fit=crop&s=ce2cb0d16d78fa92864ad1e85d316eee"),
        DummyUser(nickname: "Monica", imageUrl: "https://static.wikia.nocookie.net/friends/images/f/f6/1675c88baf466d3aa35435018dc4ead1.jpg/revision/latest/scale-to-width-down/340?cb=20200114220119"),
        DummyUser(nickname: "Rachel", imageUrl: "https://static.wikia.nocookie.net/friends/images/2/24/Rachel_long_hair.jpg/revision/latest/top-crop/width/220/height/220?cb=20190210053939"),
        DummyUser(nickname: "Alex", imageUrl: "https://i.pinimg.com/originals/fe/74/fe/fe74fe34f8378c63409b88199b138da6.jpg"),
        DummyUser(nickname: "Blair", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAW_9mshAmBbMQBJis_yP0MD6u1a14_eOSEA&usqp=CAU"),
        DummyUser(nickname: "Beckham", imageUrl: "https://media1.popsugar-assets.com/files/thumbor/RgXyD95Mslu69qvfqnG-VoR2kY8/0x279:3078x4300/fit-in/1024x1024/filters:format_auto-!!-:strip_icc-!!-/2020/05/01/641/n/2589278/0fedf8425eac30ff3248b9.68958552_/i/Most-Gorgeous-Photos-David-Beckham.jpg"),
        DummyUser(nickname: "Anne", imageUrl: "https://static.wikia.nocookie.net/interstellarfilm/images/f/f8/Anne-hathaway-013.jpg/revision/latest/scale-to-width-down/340?cb=20161013100015"),
        DummyUser(nickname: "Marcelo", imageUrl: "https://i.pinimg.com/originals/2a/18/65/2a1865a7125e9ba4070501e223f91159.png"),
        DummyUser(nickname: "Ramos", imageUrl: "https://static.independent.co.uk/s3fs-public/thumbnails/image/2020/07/07/12/Sergio-Ramos.jpg"),
        DummyUser(nickname: "Blake", imageUrl: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/serena-gossip-girl-1588587514.jpg?crop=1.00xw:0.610xh;0,0.0467xh&resize=480:*"),
        DummyUser(nickname: "Blair", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAW_9mshAmBbMQBJis_yP0MD6u1a14_eOSEA&usqp=CAU")
    ]
}

extension FollowingViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "following_table_view_cell", for: indexPath) as! FollowingTableViewCell
        let url = URL(string: users[indexPath.row].imageUrl)
        cell.imageViewAvatar.kf.setImage(with: url)
        cell.labelNickname.text = users[indexPath.row].nickname
        return cell
    }
}

extension FollowingViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Following")
    }
}

struct DummyUser {
    var nickname: String
    var imageUrl: String
}
