import Foundation
import UIKit

import Foundation

enum AppStoryboard: String {
    case signUp = "SignUp"
    case main = "Main"
    case home = "Home"
    case follow = "Follow"
    case profile = "Profile"
}

protocol Storyboarded {
    static var storyboard: AppStoryboard { get }
    static func instantiate() -> Self
}

extension Storyboarded {
    static func instantiate() -> Self {
        let identifier = String(describing: self)
        let uiStoryboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        let viewController = uiStoryboard.instantiateViewController(withIdentifier: identifier) as! Self

        return viewController
    }
}
