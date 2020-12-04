import UIKit
import RxSwift
import RxCocoa

class BaseTableViewController: UITableViewController {
    private var disposeBag = DisposeBag()
    
    override func viewDidDisappear(_ animated: Bool) {
        self.disposeBag = DisposeBag()
    }
}
