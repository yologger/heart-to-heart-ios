import UIKit
import RxSwift

enum ProfileCoordinatorOptions {
    case showChangeNicknameVC
    case closeChangeNicknameVC
    case showGetCurrentPasswordVC
    case closeGetCurrentPasswordVC
    case showChangePasswordVC
    case closeChangePasswordVC
}

class ProfileCoordinator: BaseCoordinator {
    
    private let disposeBag = DisposeBag()
    
    private var profileViewController: ProfileViewController?
    private var changeNicknameViewController: ChangeNicknameViewController?
    private var getCurrentPasswordViewController: GetCurrentPasswordViewController?
    private var changePasswordViewController: ChangePasswordViewController?
    
    private let profileViewModel: ProfileViewModel
    private let changeNicknameViewModel: ChangeNicknameViewModel
    private let getCurrentPasswordViewModel: GetCurrentPasswordViewModel
    private let changePasswordViewModel: ChangePasswordViewModel
    
    init(profileViewModel: ProfileViewModel, changeNicknameViewModel: ChangeNicknameViewModel, getCurrentPasswordViewModel: GetCurrentPasswordViewModel, changePasswordViewModel: ChangePasswordViewModel) {
        self.profileViewModel = profileViewModel
        self.changeNicknameViewModel = changeNicknameViewModel
        self.getCurrentPasswordViewModel = getCurrentPasswordViewModel
        self.changePasswordViewModel = changePasswordViewModel
    }
    
    override func start() {
        // self.navigationController.isNavigationBarHidden = true
        
        self.profileViewController = ProfileViewController.instantiate()
        self.profileViewController!.viewModel = self.profileViewModel
        self.navigationController.viewControllers = [self.profileViewController!]
        
        self.bindToProfileViewModel()
        self.bindToChangeNicknameViewModel()
        self.bindToGetCurrentPasswordViewModel()
        self.bindToChangePasswordViewModel()
    }
    
    private func bindToProfileViewModel() {
        self.profileViewModel.didCoordinatorChange
        .subscribe(
            onNext: { value in
                switch value {
                case .showChangeNicknameVC: self.showChangeNickname()
                case .closeChangeNicknameVC: self.showChangeNickname()
                case .showGetCurrentPasswordVC: self.showGetCurrentPassword()
                case .closeGetCurrentPasswordVC: self.closeGetCurrentPassword()
                case .showChangePasswordVC: self.showChangePassword()
                case .closeChangePasswordVC: self.closeChangePassword()
                }
            },
            onError: {error in print(error)},
            onCompleted: {print("onCompleted")},
            onDisposed: {print("onDisposed")}
        )
        .disposed(by: disposeBag)
    }
    
    
    private func bindToChangeNicknameViewModel() {
        self.changeNicknameViewModel.didCoordinatorChange
        .subscribe(
            onNext: { value in
                switch value {
                case .showChangeNicknameVC: self.showChangeNickname()
                case .closeChangeNicknameVC: self.closeChangeNickname()
                case .showGetCurrentPasswordVC: self.showGetCurrentPassword()
                case .closeGetCurrentPasswordVC: self.closeGetCurrentPassword()
                case .showChangePasswordVC: self.showChangePassword()
                case .closeChangePasswordVC: self.closeChangePassword()
                }
            },
            onError: {error in print(error)},
            onCompleted: {print("onCompleted")},
            onDisposed: {print("onDisposed")}
        )
        .disposed(by: disposeBag)
    }
    
    private func bindToGetCurrentPasswordViewModel() {
        self.getCurrentPasswordViewModel.didCoordinatorChange
        .subscribe(
            onNext: { value in
                switch value {
                case .showChangeNicknameVC: self.showChangeNickname()
                case .closeChangeNicknameVC: self.closeChangeNickname()
                case .showGetCurrentPasswordVC: self.showGetCurrentPassword()
                case .closeGetCurrentPasswordVC: self.closeGetCurrentPassword()
                case .showChangePasswordVC: self.showChangePassword()
                case .closeChangePasswordVC: self.closeChangePassword()
                }
            },
            onError: {error in print(error)},
            onCompleted: {print("onCompleted")},
            onDisposed: {print("onDisposed")}
        )
        .disposed(by: disposeBag)
    }
    
    
    private func bindToChangePasswordViewModel() {
        self.changePasswordViewModel.didCoordinatorChange
        .subscribe(
            onNext: { value in
                switch value {
                case .showChangeNicknameVC: self.showChangeNickname()
                case .closeChangeNicknameVC: self.closeChangeNickname()
                case .showGetCurrentPasswordVC: self.showGetCurrentPassword()
                case .closeGetCurrentPasswordVC: self.closeGetCurrentPassword()
                case .showChangePasswordVC: self.showChangePassword()
                case .closeChangePasswordVC: self.closeChangePassword()
                }
            },
            onError: {error in print(error)},
            onCompleted: {print("onCompleted")},
            onDisposed: {print("onDisposed")}
        )
        .disposed(by: disposeBag)
    }
    
    
    private func showChangeNickname() {
        self.changeNicknameViewController = ChangeNicknameViewController.instantiate()
        self.changeNicknameViewController?.viewModel = changeNicknameViewModel
        self.changeNicknameViewController?.hidesBottomBarWhenPushed = true
        self.navigationController.pushViewController(self.changeNicknameViewController!, animated: true)
    }

    
    private func closeChangeNickname() {
        self.navigationController.popViewController(animated: true)
    }
    
    private func showGetCurrentPassword() {
        self.getCurrentPasswordViewController = GetCurrentPasswordViewController.instantiate()
        self.getCurrentPasswordViewController?.hidesBottomBarWhenPushed = true
        self.getCurrentPasswordViewController?.viewModel = getCurrentPasswordViewModel
        self.navigationController.pushViewController(self.getCurrentPasswordViewController!, animated: true)
    }
    
    private func closeGetCurrentPassword() {
        print("closeGetCurrentPassword")
    }
    
    private func showChangePassword() {
        self.changePasswordViewController = ChangePasswordViewController.instantiate()
        self.changePasswordViewController?.viewModel = self.changePasswordViewModel
        self.navigationController.pushViewController(self.changePasswordViewController!, animated: true)
    }
    
    private func closeChangePassword() {
        self.navigationController.popToRootViewController(animated: true)
    }
}
