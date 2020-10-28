import UIKit
import RxSwift

class AppCoordinator: BaseCoordinator {
    
    private var window = UIWindow(frame: UIScreen.main.bounds)
    private var isLoggedIn = false
    
    private let disposeBag = DisposeBag()
    
    private let getSessionUseCase: GetSessionUseCase
    private let getDidLogInUseCase: GetDidLogInUseCase
    private let getDidLogOutUseCase: GetDidLogOutUseCase
    
    init(getDidLogInUseCase: GetDidLogInUseCase, getDidLogOutUseCase: GetDidLogOutUseCase, getSessionUseCase: GetSessionUseCase) {
        self.getDidLogInUseCase = getDidLogInUseCase
        self.getDidLogOutUseCase = getDidLogOutUseCase
        self.getSessionUseCase = getSessionUseCase
    }
    
    override func start() {
        self.getSessionUseCase.execute() == nil
            ? self.showAuthorization()
            : self.showMain()
        
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
        self.getDidLogInUseCase
            .execute()
            .subscribe(onNext: {
                self.showMain()
            }, onError: { error in
                
            }, onCompleted: {
                
            }, onDisposed: {
                
            }).disposed(by: self.disposeBag)
        
        self.getDidLogOutUseCase
            .execute()
            .subscribe(onNext: {
                self.showAuthorization()
            }, onError: { error in
                
            }, onCompleted: {
                
            }, onDisposed: {
                
            }).disposed(by: self.disposeBag)
    }
}
