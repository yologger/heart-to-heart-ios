import UIKit

class ProfileViewController: UIViewController, StoryboardInstantiable {
    static var storyboard = AppStoryboard.profile
    
    @IBAction func logout(_ sender: Any) {
        print("Log Out!")
    }
}
