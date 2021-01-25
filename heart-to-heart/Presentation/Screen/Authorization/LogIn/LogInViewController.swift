import UIKit
import RxSwift
import RxCocoa

class LogInViewController: UIViewController, StoryboardInstantiable {
    
    static var storyboard = AppStoryboard.logIn
    private let disposeBag = DisposeBag()
    
    var viewModel: LogInViewModel?
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelPassword: UILabel!
    
    var emailLabelHeight: NSLayoutConstraint!
    var passwordLabelHeight: NSLayoutConstraint!
    
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        self.initBinding()
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.initUI()
        textFieldEmail.text = "ronaldo@gmail.com"
        textFieldPassword.text = "12345"
        super.viewWillAppear(animated)
    }
    
    private func initBinding() {
        guard let viewModel = self.viewModel else { return }
        
        self.textFieldEmail.rx.text.orEmpty
            .bind(to: viewModel.email)
            .disposed(by: self.disposeBag)
        
        self.textFieldPassword.rx.text.orEmpty
            .bind(to: viewModel.password)
            .disposed(by: self.disposeBag)
        
        self.emailLabelHeight = labelEmail.heightAnchor.constraint(equalToConstant: 0)
        self.passwordLabelHeight = labelPassword.heightAnchor.constraint(equalToConstant: 0)
        
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
        
//        Observable
//            .combineLatest(
//                self.viewModel!.isEmailValid,
//                self.viewModel!.isPasswordValid,
//                resultSelector: { s1, s2 in s1 && s2 }
//            )
//            .subscribe { [weak self] areInputsValid in
//                if areInputsValid.element! {
//                    self?.logInButton.alpha = 1
//                    self?.logInButton.isEnabled = true
//                } else {
//                    self?.logInButton.alpha = 0.3
//                    self?.logInButton.isEnabled = false
//                }
//            }
//            .disposed(by: disposeBag)
        
        self.logInButton.rx.tap
            .bind { [weak self] in self?.viewModel?.logIn(
                email: (self?.textFieldEmail.text)!,
                password: (self?.textFieldPassword.text)!
            ) }
            .disposed(by: self.disposeBag)
        
        self.signInButton.rx.tap
            .bind { [weak self] in self?.viewModel?.signUp() }
            .disposed(by: self.disposeBag)
        
        self.forgotPasswordButton.rx.tap
            .bind { [weak self] in self?.viewModel?.findPassword() }
            .disposed(by: self.disposeBag)
    }
    
    private func initUI() {
        self.textFieldEmail.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: AppColor.Grey.light])
        
        self.textFieldPassword.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: AppColor.Grey.light])
        
        
        self.labelEmail.text = "Wrong Email Format"
        self.labelEmail.textColor = .red
        
        
        self.labelPassword.text = "Wrong Password Format"
        self.labelPassword.textColor = .red
        
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



