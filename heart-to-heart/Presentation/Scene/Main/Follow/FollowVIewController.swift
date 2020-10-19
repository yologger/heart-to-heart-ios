import UIKit
import RxSwift

class FollowViewController: UIViewController, StoryboardInstantiable {
    
    static var storyboard = AppStoryboard.follow

    private let disposeBase = DisposeBag()
    var viewModel: FollowViewModel?

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
//    @IBOutlet weak var tableView: UITableView! {
//        didSet {
//             tableView.dataSource = self
//             tableView.separatorStyle = .none
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.segmentedControl.addTarget(self, action: #selector(FollowViewController.indexChanged(_:)), for: .valueChanged)
        self.segmentedControl.setTitle("Following", forSegmentAt: 0)
        self.segmentedControl.setTitle("Follower", forSegmentAt: 1)

        self.viewModel!.showFollowing()
        // tableview에 tableview cell 등록
        // self.tableView.register(UINib(nibName: "FollowTableViewCell", bundle: nil), forCellReuseIdentifier: "follow_table_view_cell")
        
//        var items = ["first", "second"]
//        self.navigationItem.titleView = UISegmentedControl(items: items)
    }
    
    @objc func indexChanged(_ sender: UISegmentedControl) {
        if segmentedControl.selectedSegmentIndex == 0 {
            self.viewModel?.showFollowing()
        } else if segmentedControl.selectedSegmentIndex == 1 {
            self.viewModel?.showFollower()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // self.tableView.rowHeight = 200
        // 임시로 사용될 셀의 높이
        // self.tableView.estimatedRowHeight = 100
        // 동적으로 설정
        // self.tableView.rowHeight = UITableView.automaticDimension
    }
}

//extension FollowViewController: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 5
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let followTableViewCell = tableView.dequeueReusableCell(withIdentifier: "follow_table_view_cell", for: indexPath) as! FollowTableViewCell
//        return followTableViewCell
//    }
//}
