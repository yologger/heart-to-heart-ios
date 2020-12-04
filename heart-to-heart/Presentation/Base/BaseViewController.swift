import UIKit
import RxSwift
import RxCocoa

class BaseViewController: UIViewController {
    var disposeBag = DisposeBag()
    
    override func viewDidDisappear(_ animated: Bool) {
        self.disposeBag = DisposeBag()
    }
}
