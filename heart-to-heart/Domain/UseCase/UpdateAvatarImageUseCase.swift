import RxSwift
import Foundation
import UIKit

class UpdateAvatarImageUseCase {
    
    private let sessionRepository: SessionRepository
    
    var image: UIImage?
    
    init(sessionRepository: SessionRepository) {
        self.sessionRepository = sessionRepository
    }
}

extension UpdateAvatarImageUseCase: BaseUseCase {
    
    typealias Result = UpdateAvatarImageResult
    
    func call() -> Observable<UpdateAvatarImageResult> {
        guard let _image = self.image else { return Observable.empty() }
        // return Observable.empty()
        return sessionRepository.updateAvatarImage(image: _image)
    }
}
