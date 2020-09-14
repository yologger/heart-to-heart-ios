import UIKit
import RxSwift
import RxCocoa

class LogInViewController: UIViewController, StoryboardInstantiable {
    
    static var storyboard = AppStoryboard.logIn
    
    private let disposeBag = DisposeBag()
    var viewModel: LogInViewModel?
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    
    var emailErrorLabelHeight: NSLayoutConstraint!
    var passwordErrorLabelHeight: NSLayoutConstraint!
    
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var findPasswordButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        self.bindUI()
    }
    
    private func bindUI() {
        guard let viewModel = self.viewModel else { return }
        
        self.emailErrorLabelHeight = emailErrorLabel.heightAnchor.constraint(equalToConstant: 0)
        self.passwordErrorLabelHeight = passwordErrorLabel.heightAnchor.constraint(equalToConstant: 0)
  
        self.emailTextField.rx.text.orEmpty
            .bind(to: viewModel.email)
            .disposed(by: self.disposeBag)
        
        self.passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.password)
            .disposed(by: self.disposeBag)
        
        viewModel.isEmailValid.subscribe{ [weak self] isEmailValid in
            if isEmailValid.element! {
                self?.emailErrorLabelHeight.isActive = true
            } else {
                self?.emailErrorLabelHeight.isActive = false
            }
        }.disposed(by: self.disposeBag)
        
        viewModel.isPasswordValid.subscribe{ [weak self] isPasswordValid in
            if isPasswordValid.element! {
                self?.passwordErrorLabelHeight.isActive = true
            } else {
                self?.passwordErrorLabelHeight.isActive = false
            }
        }.disposed(by: self.disposeBag)
        
        Observable.combineLatest(
            self.viewModel!.isEmailValid,
            self.viewModel!.isPasswordValid,
            resultSelector: { s1, s2 in s1 && s2 }
        )
        .subscribe { [weak self] areInputsValid in
            if areInputsValid.element! {
                self?.logInButton.alpha = 1
            } else {
                self?.logInButton.alpha = 0.3
            }
            self?.logInButton.isEnabled = areInputsValid.element!
        }
        .disposed(by: disposeBag)
        
        self.logInButton.rx.tap
            .bind { [weak self] in self?.viewModel?.logIn() }
        .disposed(by: self.disposeBag)
        
        self.signInButton.rx.tap
            .bind { [weak self] in self?.viewModel?.signUp() }
        .disposed(by: self.disposeBag)
        
        self.findPasswordButton.rx.tap
        .bind { [weak self] in self?.viewModel?.findPassword() }
        .disposed(by: self.disposeBag)
    }
}
