import Swinject
import SwinjectAutoregistration

extension Container {
    func registerUseCases() {
        self.autoregister(GetSessionUseCase.self, initializer: GetSessionUseCase.init)
        self.autoregister(SignUpUseCase.self, initializer: SignUpUseCase.init)
        self.autoregister(LogInUseCase.self, initializer: LogInUseCase.init)
        self.autoregister(LogOutUseCase.self, initializer: LogOutUseCase.init)
        self.autoregister(CreatePostUseCase.self, initializer: CreatePostUseCase.init)
        self.autoregister(GetAllPostsUseCase.self, initializer: GetAllPostsUseCase.init)
    }
}
