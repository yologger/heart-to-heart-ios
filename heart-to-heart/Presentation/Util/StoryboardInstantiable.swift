import Foundation
import UIKit

import Foundation

enum AppStoryboard: String {
    case logIn = "LogIn"
    case signUp = "SignUp"
    case findPassword = "FindPassword"
    case main = "Main"
    case home = "Home"
    case follow = "Follow"
    case following = "Following"
    case follower = "Follower"
    case createPost = "CreatePost"
    case searchHistory = "SearchHistory"
    case postList = "PostList"
    case profile = "Profile"
    case changeNickname = "ChangeNickname"
    case getCurrentPassword = "GetCurrentPassword"
    case changePassword = "ChangePassword"
}

protocol StoryboardInstantiable {
    static var storyboard: AppStoryboard { get }
    static func instantiate() -> Self
}

extension StoryboardInstantiable {
    static func instantiate() -> Self {
        let identifier = String(describing: self)
        let uiStoryboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        let viewController = uiStoryboard.instantiateViewController(withIdentifier: identifier) as! Self

        return viewController
    }
}
