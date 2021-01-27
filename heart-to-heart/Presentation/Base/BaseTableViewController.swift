import UIKit
import RxSwift
import RxCocoa

class BaseTableViewController: UITableViewController {
    var disposeBag = DisposeBag()
    
    deinit {
        self.disposeBag = DisposeBag()
    }
}
