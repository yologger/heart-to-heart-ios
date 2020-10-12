import UIKit
import RxSwift

class AppCoordinator: BaseCoordinator {
    
    private var window = UIWindow(frame: UIScreen.main.bounds)
    private var isLoggedIn = true

    private let disposeBag = DisposeBag()
    private let sessionRepository: SessionRepository
    
    init(sessionRepository: SessionRepository) {
        self.sessionRepository = sessionRepository
    }
    
    override func start() {
        isLoggedIn ? showMain() : showAuthorization()
        self.subscribeSessionChange()
    }
    
    func showAuthorization() {
        self.removeChildCoordinators()
        let authorizationCoordinator = AppDelegate.container.resolve(AuthorizationCoordinator.self)!
        self.start(coordinator: authorizationCoordinator)
        self.window.rootViewController = authorizationCoordinator.navigationController
        self.window.makeKeyAndVisible()
    }
    
    func showMain() {
        self.removeChildCoordinators()
        let mainCoordinator = AppDelegate.container.resolve(MainCoordinator.self)!
        self.start(coordinator: mainCoordinator)
        self.window.rootViewController = mainCoordinator.navigationController
        self.window.makeKeyAndVisible()
    }
    
    func subscribeSessionChange() {
        self.sessionRepository.didLogIn
            .subscribe { [weak self] in self?.showMain() }
            .disposed(by: disposeBag)
        
        self.sessionRepository.didLogOut
            .subscribe { [weak self] in self?.showAuthorization() }
            .disposed(by: disposeBag)
    }
}
