import Swinject
import SwinjectAutoregistration

extension Container {
    func registerUseCases() {
        self.autoregister(LogInUseCase.self, initializer: LogInUseCase.init)
    }
}
