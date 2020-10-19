import UIKit
import RxSwift
import RxCocoa

class SignUpViewController: UIViewController, StoryboardInstantiable {
    
    static var storyboard = AppStoryboard.signUp
    
    private let disposeBag = DisposeBag()
    var viewModel: SignUpViewModel?
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var fullnameTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    var emailLabelHeight: NSLayoutConstraint!
    var fullnameLabelHeight: NSLayoutConstraint!
    var nicknameLabelHeight: NSLayoutConstraint!
    var passwordLabelHeight: NSLayoutConstraint!
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    
    override func viewDidLoad() {
        self.initBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.initUI()
    }
    
    private func initBinding() {
        
        guard let viewModel = self.viewModel else { return }

        self.emailLabelHeight = emailLabel.heightAnchor.constraint(equalToConstant: 0)
        self.fullnameLabelHeight = fullnameLabel.heightAnchor.constraint(equalToConstant: 0)
        self.nicknameLabelHeight = nicknameLabel.heightAnchor.constraint(equalToConstant: 0)
        self.passwordLabelHeight = passwordLabel.heightAnchor.constraint(equalToConstant: 0)
        
        self.emailTextField.rx.text.orEmpty
            .bind(to: viewModel.email)
            .disposed(by: self.disposeBag)

        self.fullnameTextField.rx.text.orEmpty
            .bind(to: viewModel.fullName)
            .disposed(by: self.disposeBag)

        self.nicknameTextField.rx.text.orEmpty
            .bind(to: viewModel.nickname)
            .disposed(by: self.disposeBag)

        self.passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.password)
            .disposed(by: self.disposeBag)
        
        viewModel.isEmailValid.subscribe { [weak self] isEmailValid in
            if isEmailValid.element! {
                self?.emailLabelHeight.isActive = true
            } else {
                self?.emailLabelHeight.isActive = false
            }
        }.disposed(by: self.disposeBag)

        viewModel.isFullNameValid.subscribe { [weak self] isFullNameValid in
            if isFullNameValid.element! {
                self?.fullnameLabelHeight.isActive = true
            } else {
                self?.fullnameLabelHeight.isActive = false
            }
        }.disposed(by: self.disposeBag)

        viewModel.isNicknameValid.subscribe { [weak self] isNicknameValid in
            if isNicknameValid.element! {
                self?.nicknameLabelHeight.isActive = true
            } else {
                self?.nicknameLabelHeight.isActive = false
            }
        }.disposed(by: self.disposeBag)

        viewModel.isPasswordValid.subscribe { [weak self] isPasswordValid in
            if isPasswordValid.element! {
                self?.passwordLabelHeight.isActive = true
            } else {
                self?.passwordLabelHeight.isActive = false
            }
        }.disposed(by: self.disposeBag)

        self.logInButton.rx.tap
            .bind { [weak self] in self?.viewModel?.logIn() }
            .disposed(by: self.disposeBag)

        self.signUpButton.rx.tap
            .bind { [weak self] in self?.viewModel?.signUp() }
            .disposed(by: self.disposeBag)
    }
    
    @objc func keyboardWillShow(_ notification:NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            scrollView.contentInset.bottom = keyboardHeight - self.view.safeAreaInsets.bottom
            scrollView.verticalScrollIndicatorInsets.bottom = keyboardHeight - self.view.safeAreaInsets.bottom
        }
    }
    
    @objc func keyboardWillHide(_ notification:NSNotification) {
        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets.bottom = 0
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    private func initUI() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.emailTextField.placeholder = "Email"
        self.fullnameTextField.placeholder = "Full Name"
        self.nicknameTextField.placeholder = "Nickname"
        self.passwordTextField.placeholder = "Password"
        
        self.emailTextField.clearButtonMode = .whileEditing
        self.fullnameTextField.clearButtonMode = .whileEditing
        self.nicknameTextField.clearButtonMode = .whileEditing
        self.passwordTextField.isSecureTextEntry = true
    }
}
