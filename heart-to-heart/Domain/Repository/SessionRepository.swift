import RxSwift
import UIKit

protocol SessionRepository: BaseRepository {
    func fetchCurrentUserInformation() -> Observable<FetchCurrentUserInformationResult>
    func getSessionState() -> Observable<Bool>
    func signUp(email: String, firstName: String, lastName: String,  nickname: String, password: String) -> Observable<SignUpResponse>
    func logIn(email: String, password: String) -> Observable<LogInResult>
    func logOut() -> Observable<LogOutResult>
    func updateAvatarImage(image: UIImage) -> Observable<UpdateAvatarImageResult>
}
