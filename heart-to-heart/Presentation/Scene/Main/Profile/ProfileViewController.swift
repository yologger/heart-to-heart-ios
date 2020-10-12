import UIKit

class ProfileViewController: UITableViewController, StoryboardInstantiable {
    
    static var storyboard = AppStoryboard.profile
    var viewModel: ProfileViewModel?
    
    override func viewDidLoad() {
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 200
        // self.tableView.separatorStyle = .none
        
    }
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear from ProfileViewController")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear from ProfileViewController")
    }
}


//class ProfileViewController: UITableViewController, StoryboardInstantiable {
//
//    static var storyboard = AppStoryboard.profile
//    var viewModel: ProfileViewModel?
//
//    override func viewDidLoad() {
//        print("viewDidLoad() from ProfileViewController")
//
//    }
//    override func viewWillAppear(_ animated: Bool) {
//        print("viewWillAppear from ProfileViewController")
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        print("viewWillDisappear from ProfileViewController")
//    }
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        switch indexPath.section {
//        case 0:
//            handleZerothSection(indexPath: indexPath)
//        case 1:
//            handleFirstSection(indexPath: indexPath)
//        case 2:
//            handleSecondSection(indexPath: indexPath)
//        default:
//            print("ERROR")
//        }
//    }
//
//    private func handleZerothSection(indexPath: IndexPath) {
//
//    }
//
//    private func handleFirstSection(indexPath: IndexPath) {
//
//    }
//
//    private func handleSecondSection(indexPath: IndexPath) {
//        switch indexPath.item {
//        case 0:
//            self.changeNickname()
//        case 1:
//            self.changePassword()
//        case 2:
//            self.logOut()
//        default:
//            print("Error")
//        }
//    }
//
//    private func changePassword() {
//
//    }
//
//    private func changeNickname() {
//        print("changeNickname")
//    }
//
//    private func logOut() {
//
//        print("logOut")
//        viewModel?.logOut()
//    }
//}

