import Swinject
import SwinjectAutoregistration

extension Container {
    
    func registerDependencies() {
        self.registerCoordinators()
        self.registerViewModels()
        self.registerUseCases()
        self.registerRepositories()
        self.registerDataSources()
    }
}
