import UIKit
import RxSwift
import RxCocoa

class ChangeNicknameViewController: UIViewController, StoryboardInstantiable {
    
    static var storyboard = AppStoryboard.changeNickname
    
    private let disposeBag = DisposeBag()
    var viewModel: ChangeNicknameViewModel?
    
    @IBOutlet weak var nicknameTextfield: UITextField!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        self.bindUI()
    }
    
    private func bindUI() {
        guard let viewModel = self.viewModel else { return }
        
        self.button.rx.tap
            .bind { [weak self] in self?.viewModel?.changeNickname() }
            .disposed(by: self.disposeBag)
        
    }
}
