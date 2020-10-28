import Swinject
import SwinjectAutoregistration

extension Container {
    func registerInfrastructure() {
         self.autoregister(KeyChainService.self, initializer: KeyChainService.init)
    }
}
