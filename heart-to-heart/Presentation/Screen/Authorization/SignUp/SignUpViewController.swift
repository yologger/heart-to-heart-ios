import UIKit
import RxSwift
import RxCocoa

class SignUpViewController: UIViewController, StoryboardInstantiable {
    
    static var storyboard = AppStoryboard.signUp
    
    private let disposeBag = DisposeBag()
    var viewModel: SignUpViewModel?
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
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
                
//        emailTextField.text = "sonny@gmail.com"
//        firstnameTextField.text = "Heungmin"
//        lastnameTextField.text = "Son"
//        nicknameTextField.text = "sonny92"
//        passwordTextField.text = "PW123Son!"
        
        emailTextField.text = "ronaldo@gmail.com"
        firstnameTextField.text = "Cristiano"
        lastnameTextField.text = "Ronaldo"
        nicknameTextField.text = "CR9"
        passwordTextField.text = "12345"
        
        emailLabel.textColor = AppColor.White.normal
        fullnameLabel.textColor = AppColor.White.normal
        nicknameLabel.textColor = AppColor.White.normal
        passwordLabel.textColor = AppColor.White.normal
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

        self.firstnameTextField.rx.text.orEmpty
            .bind(to: viewModel.firstname)
            .disposed(by: self.disposeBag)

        self.lastnameTextField.rx.text.orEmpty
            .bind(to: viewModel.lastname)
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

//        viewModel.isFullNameValid.subscribe { [weak self] isFullNameValid in
//            if isFullNameValid.element! {
//                self?.fullnameLabelHeight.isActive = true
//            } else {
//                self?.fullnameLabelHeight.isActive = false
//            }
//        }.disposed(by: self.disposeBag)
//
//        viewModel.isNicknameValid.subscribe { [weak self] isNicknameValid in
//            if isNicknameValid.element! {
//                self?.nicknameLabelHeight.isActive = true
//            } else {
//                self?.nicknameLabelHeight.isActive = false
//            }
//        }.disposed(by: self.disposeBag)
//
//        viewModel.isPasswordValid.subscribe { [weak self] isPasswordValid in
//            if isPasswordValid.element! {
//                self?.passwordLabelHeight.isActive = true
//            } else {
//                self?.passwordLabelHeight.isActive = false
//            }
//        }.disposed(by: self.disposeBag)

        self.logInButton.rx.tap
            .bind { [weak self] in self?.viewModel?.logIn() }
            .disposed(by: self.disposeBag)

        self.signUpButton.rx.tap
            .bind { [weak self] in
                guard let email = self?.emailTextField.text,
                    let firstName = self?.firstnameTextField.text,
                    let lastName = self?.lastnameTextField.text,
                    let nickname = self?.nicknameTextField.text,
                    let password = self?.passwordTextField.text else { return }
                self?.viewModel?.signUp(
                    email: email,
                    firstName: firstName,
                    lastName: lastName,
                    nickname: nickname,
                    password: password
                )
            }
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
        
        self.emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: AppColor.Grey.light])
        self.firstnameTextField.attributedPlaceholder = NSAttributedString(string: "First Name", attributes: [NSAttributedString.Key.foregroundColor: AppColor.Grey.light])
        self.lastnameTextField.attributedPlaceholder = NSAttributedString(string: "Last Name", attributes: [NSAttributedString.Key.foregroundColor: AppColor.Grey.light])
        self.nicknameTextField.attributedPlaceholder = NSAttributedString(string: "Nickname", attributes: [NSAttributedString.Key.foregroundColor: AppColor.Grey.light])
        self.passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: AppColor.Grey.light])
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)

        
        self.emailTextField.clearButtonMode = .whileEditing
        self.firstnameTextField.clearButtonMode = .whileEditing
        self.lastnameTextField.clearButtonMode = .whileEditing
        self.nicknameTextField.clearButtonMode = .whileEditing
        self.passwordTextField.isSecureTextEntry = true
        self.passwordTextField.clearButtonMode = .whileEditing
    }
}
