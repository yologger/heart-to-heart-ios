import UIKit
import RxSwift

enum AuthorizationCoordinatorOptions {
    case showSignUpVC
    case closeSignUpVC
    case showLogInVC
    case closeLogInVC
    case showFindPasswordVC
    case closeFindPasswordVC
}

class AuthorizationCoordinator: BaseCoordinator {
    
    private let disposeBag = DisposeBag()
    
    private var logInViewController: LogInViewController?
    private var signUpViewController: SignUpViewController?
    private var findPasswordViewController: FindPasswordViewController?
    
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
    
    private func bindLogInViewModel() {
        self.logInViewModel.didCoordinatorChange
            .subscribe(
                onNext: { value in
                    switch value {
                    case .showLogInVC: self.showLogIn()
                    case .closeLogInVC: self.closeLogIn()
                    case .showSignUpVC: self.showSignUp()
                    case .closeSignUpVC: self.closeSignUp()
                    case .showFindPasswordVC: self.showFindPassword()
                    case .closeFindPasswordVC: self.closeFindPassword()
                    }
            },
                onError: { error in print(error) },
                onCompleted: { print("onCompleted") },
                onDisposed: { print("onDisposed") }
            )
            .disposed(by: disposeBag)
    }
    
    
    private func bindSignUpViewModel() {
        
        self.signUpViewModel.didCoordinatorChange
            .subscribe(
                onNext: { value in
                    switch value {
                    case .showLogInVC: self.showLogIn()
                    case .closeLogInVC: self.closeLogIn()
                    case .showSignUpVC: self.showSignUp()
                    case .closeSignUpVC: self.closeSignUp()
                    case .showFindPasswordVC: self.showFindPassword()
                    case .closeFindPasswordVC: self.closeFindPassword()
                    }
            },
                onError: { error in print(error) },
                onCompleted: { print("onCompleted") },
                onDisposed: { print("onDisposed") }
            )
            .disposed(by: disposeBag)
    }
    
    private func bindFindPasswordViewModel() {
        
    }
    
    
    private func showLogIn() {
        self.logInViewController = LogInViewController.instantiate()
        self.logInViewController?.viewModel = logInViewModel
        self.navigationController.isNavigationBarHidden = true
        self.navigationController.viewControllers = [self.logInViewController!]
    }
    
    private func closeLogIn() {
    }
    
    private func showSignUp() {
        self.signUpViewController = SignUpViewController.instantiate()
        self.signUpViewController?.viewModel = self.signUpViewModel
        self.signUpViewController?.modalPresentationStyle = .fullScreen
        self.navigationController.present(self.signUpViewController!, animated: false, completion: nil)
    }
    
    private func closeSignUp() {
        self.navigationController.dismiss(animated: false, completion: nil)
        self.signUpViewController = nil
    }
    
    private func showFindPassword() {
        self.findPasswordViewController = FindPasswordViewController.instantiate()
        self.findPasswordViewController?.viewModel = self.findPasswordViewModel
        self.findPasswordViewController?.modalPresentationStyle = .fullScreen
        self.navigationController.present(self.findPasswordViewController!, animated: false, completion: nil)
    }
    
    private func closeFindPassword() {
    }
}

