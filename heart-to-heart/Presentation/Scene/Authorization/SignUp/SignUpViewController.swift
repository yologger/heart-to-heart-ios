import UIKit
import RxSwift
import RxCocoa

class SignUpViewController: UIViewController, StoryboardInstantiable {
    
    static var storyboard = AppStoryboard.signUp
    
    private let disposeBag = DisposeBag()
    var viewModel: SignUpViewModel?
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var emailErrorMessageLabel: UILabel!
    @IBOutlet weak var fullNameErrorMessageLabel: UILabel!
    @IBOutlet weak var nicknameErrorMessage: UILabel!
    @IBOutlet weak var passwordErrorMessage: UILabel!
    
    var emailErrorLabelHeight: NSLayoutConstraint!
    var fullNameErrorLabelHeight: NSLayoutConstraint!
    var nicknameErrorLabelHeight: NSLayoutConstraint!
    var passwordErrorLabelHeight: NSLayoutConstraint!
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    
    override func viewDidLoad() {
        self.bindUI()
    }
    
    private func bindUI() {
        guard let viewModel = self.viewModel else { return }
        
        self.emailErrorLabelHeight = emailErrorMessageLabel.heightAnchor.constraint(equalToConstant: 0)
        self.fullNameErrorLabelHeight = fullNameErrorMessageLabel.heightAnchor.constraint(equalToConstant: 0)
        self.nicknameErrorLabelHeight = nicknameErrorMessage.heightAnchor.constraint(equalToConstant: 0)
        self.passwordErrorLabelHeight = passwordErrorMessage.heightAnchor.constraint(equalToConstant: 0)
        
        self.emailTextField.rx.text.orEmpty
            .bind(to: viewModel.email)
            .disposed(by: self.disposeBag)
        
        self.fullNameTextField.rx.text.orEmpty
            .bind(to: viewModel.fullName)
            .disposed(by: self.disposeBag)
        
        self.nicknameTextField.rx.text.orEmpty
            .bind(to: viewModel.nickname)
            .disposed(by: self.disposeBag)
        
        self.passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.password)
            .disposed(by: self.disposeBag)
//        
//        viewModel.isEmailValid.subscribe { [weak self] isEmailValid in
//            if isEmailValid.element! {
//                self?.emailErrorLabelHeight.isActive = true
//            } else {
//                self?.emailErrorLabelHeight.isActive = false
//            }
//        }.disposed(by: self.disposeBag)
//        
//        viewModel.isFullNameValid.subscribe { [weak self] isFullNameValid in
//            if isFullNameValid.element! {
//                self?.fullNameErrorLabelHeight.isActive = true
//            } else {
//                self?.fullNameErrorLabelHeight.isActive = false
//            }
//        }.disposed(by: self.disposeBag)
//        
//        viewModel.isNicknameValid.subscribe { [weak self] isNicknameValid in
//            if isNicknameValid.element! {
//                self?.nicknameErrorLabelHeight.isActive = true
//            } else {
//                self?.nicknameErrorLabelHeight.isActive = false
//            }
//        }.disposed(by: self.disposeBag)
//        
//        viewModel.isPasswordValid.subscribe { [weak self] isPasswordValid in
//            if isPasswordValid.element! {
//                self?.passwordErrorLabelHeight.isActive = true
//            } else {
//                self?.passwordErrorLabelHeight.isActive = false
//            }
//        }.disposed(by: self.disposeBag)
//        
        self.logInButton.rx.tap
            .bind { [weak self] in self?.viewModel?.logIn() }
            .disposed(by: self.disposeBag)
        
        self.signUpButton.rx.tap
            .bind { [weak self] in self?.viewModel?.signUp() }
            .disposed(by: self.disposeBag)
    }
}
