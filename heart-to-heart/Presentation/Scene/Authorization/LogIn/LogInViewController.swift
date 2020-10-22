import UIKit
import RxSwift
import RxCocoa

class LogInViewController: UIViewController, StoryboardInstantiable {
    
    static var storyboard = AppStoryboard.logIn
    private let disposeBag = DisposeBag()
    
    var viewModel: LogInViewModel?
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    var emailLabelHeight: NSLayoutConstraint!
    var passwordLabelHeight: NSLayoutConstraint!
    
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.initUI()
        emailTextField.text = "sonny@gmail.com"
        passwordTextField.text = "PW123Son!"
    }
    
    private func initBinding() {
        guard let viewModel = self.viewModel else { return }
        
        self.emailTextField.rx.text.orEmpty
            .bind(to: viewModel.email)
            .disposed(by: self.disposeBag)
        
        self.passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.password)
            .disposed(by: self.disposeBag)

        self.emailLabelHeight = emailLabel.heightAnchor.constraint(equalToConstant: 0)
        self.passwordLabelHeight = passwordLabel.heightAnchor.constraint(equalToConstant: 0)
        
        viewModel.isEmailValid.subscribe{ [weak self] isEmailValid in
            if isEmailValid.element! {
                self?.emailLabelHeight.isActive = true
            } else {
                self?.emailLabelHeight.isActive = false
            }
        }.disposed(by: self.disposeBag)
        
        viewModel.isPasswordValid.subscribe{ [weak self] isPasswordValid in
            if isPasswordValid.element! {
                self?.passwordLabelHeight.isActive = true
            } else {
                self?.passwordLabelHeight.isActive = false
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
                self?.logInButton.isEnabled = true
            } else {
                self?.logInButton.alpha = 0.3
                self?.logInButton.isEnabled = false
            }
        }
        .disposed(by: disposeBag)
        
        self.logInButton.rx.tap
            .bind { [weak self] in self?.viewModel?.logIn() }
            .disposed(by: self.disposeBag)

        self.signInButton.rx.tap
            .bind { [weak self] in self?.viewModel?.signUp() }
            .disposed(by: self.disposeBag)

        self.forgotPasswordButton.rx.tap
            .bind { [weak self] in self?.viewModel?.findPassword() }
            .disposed(by: self.disposeBag)
    }
    
    private func initUI() {
        self.initEmailTextField()
        self.initPasswordTextField()
        self.initEmailLabel()
        self.initPasswordLabel()
        self.initLogInButton()
    }
    
    private func initEmailTextField() {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: emailTextField.frame.size.height-1, width: emailTextField.frame.width, height: 1)
        border.backgroundColor = UIColor.black.cgColor

        emailTextField.layer.addSublayer(border)
        emailTextField.textColor = UIColor.black
        emailTextField.backgroundColor = .orange
        self.emailTextField.clearButtonMode = .whileEditing
    }
    
    private func initPasswordTextField() {
//        let border = CALayer()
//        border.frame = CGRect(x: 0, y: passwordTextField.frame.size.height-1, width: passwordTextField.frame.width, height: 1)
//        border.backgroundColor = UIColor.black.cgColor
//
//        passwordTextField.layer.addSublayer(border)
//        passwordTextField.textColor = UIColor.black
//        passwordTextField.backgroundColor = .orange
//        self.passwordTextField.clearButtonMode = .whileEditing
    }
    
    private func initEmailLabel() {
        self.emailLabel.text = "Wrong Email Format"
        self.emailLabel.textColor = .red
    }
    
    private func initPasswordLabel() {
        self.passwordLabel.text = "Wrong Password Format"
        self.passwordLabel.textColor = .red
    }
    
    private func initLogInButton() {
        self.logInButton.backgroundColor = .blue
        self.logInButton.setTitleColor(.white, for: .normal)
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
}
