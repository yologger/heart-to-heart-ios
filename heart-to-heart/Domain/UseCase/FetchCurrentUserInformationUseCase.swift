import RxSwift

final class FetchCurrentUserInformationUseCase {
    
    private let sessionRepository: SessionRepository
    
    init(sessionRepository: SessionRepository) {
        self.sessionRepository = sessionRepository
    }
}

extension FetchCurrentUserInformationUseCase: BaseUseCase {
    
    typealias Result = FetchCurrentUserInformationResult
    
    func call() -> Observable<FetchCurrentUserInformationResult> {
        return sessionRepository.fetchCurrentUserInformation()
    }
}
