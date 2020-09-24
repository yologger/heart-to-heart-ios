import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController, StoryboardInstantiable {
 
    static var storyboard = AppStoryboard.home
    
    private let disposeBag = DisposeBag()
    var viewModel: HomeViewModel?
    
    @IBOutlet weak var tableView: UITableView!
    
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
        self.tableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "post_table_view_cell")
        
        self.navigationItem.rightBarButtonItem = self.rightButton
    
        behaviorSubject.subscribe{ value in print(value)}.disposed(by: disposeBag)
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
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postTableViewCell = tableView.dequeueReusableCell(withIdentifier: "post_table_view_cell", for: indexPath) as! PostTableViewCell
        return postTableViewCell
    }
}
