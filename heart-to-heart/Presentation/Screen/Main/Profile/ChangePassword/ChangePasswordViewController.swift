import UIKit
import RxSwift
import RxCocoa

class ChangePasswordViewController: UIViewController, StoryboardInstantiable {
    
    static var storyboard: AppStoryboard = .changePassword
    
    private let disposeBag = DisposeBag()
    var viewModel: ChangePasswordViewModel?
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var changePasswordButton: UIButton!
    
    override func viewDidLoad() {
        self.bindUI()
    }
    
    private func bindUI() {
        guard let viewModel = self.viewModel else { return }
        
        self.changePasswordButton.rx.tap
            .bind { [weak self] in self?.viewModel?.changePassword() }
            .disposed(by: self.disposeBag)
        
    }
}
