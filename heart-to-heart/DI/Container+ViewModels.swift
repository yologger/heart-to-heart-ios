import Swinject
import SwinjectAutoregistration

extension Container {
    func registerViewModels() {
        self.autoregister(LogInViewModel.self, initializer: LogInViewModel.init)
        self.autoregister(SignUpViewModel.self, initializer: SignUpViewModel.init)
        self.autoregister(FindPasswordViewModel.self, initializer: FindPasswordViewModel.init)
    }
}
