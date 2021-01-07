import UIKit
import Swinject
import SwinjectAutoregistration

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private var appCoordinator: AppCoordinator?
    var window: UIWindow?
    
    static let container = Container()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Initialize Swinject Container
        AppDelegate.container.registerDependencies()
        
        // Initialize Coordinator
        self.appCoordinator = AppDelegate.container.resolve(AppCoordinator.self)
        self.appCoordinator?.start()
        
        return true
    }
}
