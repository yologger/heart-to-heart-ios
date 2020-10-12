import UIKit
import RxSwift

enum ProfileCoordinatorOptions {
    case showChangePasswordVC
    case closeChangePasswordVC
}

class ProfileCoordinator: BaseCoordinator {
    
    private let disposeBag = DisposeBag()
    
    private let profileViewModel: ProfileViewModel
    private let changePasswordViewModel: ChangePasswordViewModel
    
    init(profileViewModel: ProfileViewModel, changePasswordViewModel: ChangePasswordViewModel) {
        self.profileViewModel = profileViewModel
        self.changePasswordViewModel = changePasswordViewModel
    }
    
    override func start() {
        print("start() from ProfileCoordinator")
        let profileViewController = ProfileViewController.instantiate()
        // self.navigationController.isNavigationBarHidden = true
        self.navigationController.viewControllers = [profileViewController]
        
        self.bindToProfileViewModel()
    }
    
    func bindToProfileViewModel() {
        self.profileViewModel.didCoordinatorChange
        .subscribe(
            onNext: { value in
                switch value {
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
    
    private func showChangePassword() {
        // print("showChangePassword")
    }
    
    private func closeChangePassword() {
        // print("closeChangePassword")
    }
}
