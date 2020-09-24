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
    case profile = "Profile"
    case createPost = "CreatePost"
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
