import UIKit
import RxCocoa
import RxSwift

class GetCurrentPasswordViewController: UIViewController, StoryboardInstantiable {
    
    static var storyboard: AppStoryboard = .getCurrentPassword
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    
    private let disposeBag = DisposeBag()
    var viewModel: GetCurrentPasswordViewModel?
    
    override func viewDidLoad() {
        self.bindUI()
    }
    
    private func bindUI() {
        guard let viewModel = self.viewModel else { return }
        
        self.passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.password)
            .disposed(by: self.disposeBag)
        
        self.confirmButton.rx.tap
            .bind { [weak self] in self?.viewModel?.checkCurrentPassword() }
            .disposed(by: self.disposeBag)
    }
}
