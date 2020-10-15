import Swinject
import SwinjectAutoregistration

extension Container {
    func registerUseCases() {
        self.autoregister(SignUpUseCase.self, initializer: SignUpUseCase.init)
        self.autoregister(LogInUseCase.self, initializer: LogInUseCase.init)
        self.autoregister(GetAllPostsUseCase.self, initializer: GetAllPostsUseCase.init)
        self.autoregister(CreatePostUseCase.self, initializer: CreatePostUseCase.init)
    }
}
