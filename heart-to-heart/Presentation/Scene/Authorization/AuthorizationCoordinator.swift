import UIKit
import RxSwift

class AuthorizationCoordinator: BaseCoordinator {
    
    private let disposeBag = DisposeBag()
    
    private let logInViewModel: LogInViewModel
    private let signUpViewModel: SignUpViewModel
    private let findPasswordViewModel: FindPasswordViewModel
    
    init(logInViewModel: LogInViewModel, signUpViewModel: SignUpViewModel, findPasswordViewModel: FindPasswordViewModel) {
        self.logInViewModel = logInViewModel
        self.signUpViewModel = signUpViewModel
        self.findPasswordViewModel = findPasswordViewModel
    }
    
    override func start() {
        
        self.showLogIn()
        self.bindLogInViewModel()
        self.bindSignUpViewModel()
        self.bindFindPasswordViewModel()
    }
    
    func showLogIn() {
        let logInViewController = LogInViewController.instantiate()
        logInViewController.viewModel = logInViewModel
        self.navigationController.isNavigationBarHidden = true
        self.navigationController.viewControllers = [logInViewController]
    }
    
    private func bindLogInViewModel() {
        
        self.logInViewModel.didClickLogInButton
            .distinctUntilChanged()
            .subscribe { [weak self] isButtonClicked in
                if isButtonClicked.element! {
                    
                } else { }
        }.disposed(by: self.disposeBag)
        
        self.logInViewModel.didClickFindPasswordButton
            .distinctUntilChanged()
            .subscribe { [weak self] isButtonClicked in
                if isButtonClicked.element! {
                    let findPasswordViewController = FindPasswordViewController.instantiate()
                    findPasswordViewController.viewModel = self?.findPasswordViewModel
                    findPasswordViewController.modalPresentationStyle = .fullScreen
                    self?.navigationController.present(findPasswordViewController, animated: false, completion: nil)
                } else {}
        }.disposed(by: self.disposeBag)
        
        self.logInViewModel.didClickSignUpButton
            .subscribe { [weak self] isButtonClicked in
                if isButtonClicked.element! {
                    let signUpViewController = SignUpViewController.instantiate()
                    signUpViewController.viewModel = self?.signUpViewModel
                    signUpViewController.modalPresentationStyle = .fullScreen
                    self?.navigationController.present(signUpViewController, animated: false, completion: nil)
                } else { }
        }.disposed(by: self.disposeBag)
    }
    
    private func bindSignUpViewModel() {
        
        self.signUpViewModel.didClickLogInButton
            .subscribe { [weak self] isButtonClicked in
                if isButtonClicked.element! {
                    self?.navigationController.dismiss(animated: false, completion: nil)
                } else { }
        }.disposed(by: self.disposeBag)
        
        self.signUpViewModel.didClickSignUpButton
            .distinctUntilChanged()
            .subscribe { [weak self] isButtonClicked in
                
        }.disposed(by: self.disposeBag)
    }
    
    private func bindFindPasswordViewModel() {
        
    }
}

