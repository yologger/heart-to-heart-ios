import UIKit
import RxSwift

class AppCoordinator: BaseCoordinator {
    
    private var window = UIWindow(frame: UIScreen.main.bounds)
    private var isLoggedIn = false
    
    private var disposeBag = DisposeBag()
    
    private let getSessionUseCase: GetSessionUseCase
    
    init(getSessionUseCase: GetSessionUseCase) {
        self.getSessionUseCase = getSessionUseCase
    }
    
    override func start() {
        self.getSessionUseCase.execute().subscribe(onNext: { isLoggedIn in
            isLoggedIn == false
                ? self.showAuthorization()
                : self.showMain()
        }, onError: { error in
            
        }, onCompleted: {
            
        }, onDisposed: {
            
        }).disposed(by: self.disposeBag)
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
    
    deinit {
        self.disposeBag = DisposeBag()
    }
}
