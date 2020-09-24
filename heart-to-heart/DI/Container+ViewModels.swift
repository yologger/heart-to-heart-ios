import Swinject
import SwinjectAutoregistration

extension Container {
    func registerViewModels() {
        self.autoregister(LogInViewModel.self, initializer: LogInViewModel.init)
        self.autoregister(SignUpViewModel.self, initializer: SignUpViewModel.init)
        self.autoregister(FindPasswordViewModel.self, initializer: FindPasswordViewModel.init)
        self.autoregister(HomeViewModel.self, initializer: HomeViewModel.init)
        self.autoregister(CreatePostViewModel.self, initializer: CreatePostViewModel.init)
    }
}
