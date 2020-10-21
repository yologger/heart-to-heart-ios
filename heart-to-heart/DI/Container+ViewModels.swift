import Swinject
import SwinjectAutoregistration

extension Container {
    func registerViewModels() {
        self.autoregister(LogInViewModel.self, initializer: LogInViewModel.init)
        self.autoregister(SignUpViewModel.self, initializer: SignUpViewModel.init)
        self.autoregister(FindPasswordViewModel.self, initializer: FindPasswordViewModel.init)
        self.autoregister(HomeViewModel.self, initializer: HomeViewModel.init)
        self.autoregister(PostListViewModel.self, initializer: PostListViewModel.init)
        self.autoregister(CreatePostViewModel.self, initializer: CreatePostViewModel.init)
        self.autoregister(SearchHistoryViewModel.self, initializer: SearchHistoryViewModel.init)
        self.autoregister(FollowViewModel.self, initializer: FollowViewModel.init)
        self.autoregister(FollowingViewModel.self, initializer: FollowingViewModel.init)
        self.autoregister(FollowerViewModel.self, initializer: FollowerViewModel.init)
        self.autoregister(ProfileViewModel.self, initializer: ProfileViewModel.init)
        self.autoregister(ChangeNicknameViewModel.self, initializer: ChangeNicknameViewModel.init)
        self.autoregister(GetCurrentPasswordViewModel.self, initializer: GetCurrentPasswordViewModel.init)
        self.autoregister(ChangePasswordViewModel.self, initializer: ChangePasswordViewModel.init)
    }
}
