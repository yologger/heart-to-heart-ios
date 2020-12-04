import Swinject
import SwinjectAutoregistration

extension Container {
    func registerInfrastructure() {
        self.autoregister(KeyChainService.self, initializer: KeyChainService.init)
        self.autoregister(AuthInterceptor.self, initializer: AuthInterceptor.init)
        
        self.autoregister(SignUpService.self, initializer: SignUpService.init)
        self.autoregister(LogInService.self, initializer: LogInService.init)
        self.autoregister(LogOutService.self, initializer: LogOutService.init)
    }
}
