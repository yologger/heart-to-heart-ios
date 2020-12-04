import UIKit

class ProfileViewController: UITableViewController, StoryboardInstantiable {
    
    static var storyboard = AppStoryboard.profile
    var viewModel: ProfileViewModel?
    
    override func viewDidLoad() {
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 200
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0: break
        case 1: break
        case 2: didRowClick(row: indexPath.row)
        default:
            print("ERROR")
        }
    }
    
    private func didRowClick(row: Int) {
        switch row {
        case 0: self.changeNickname()
        case 1: self.changePassword()
        case 2: self.logout()
        default:
            print("Error")
        }
    }
    
    private func changeNickname() {
        self.viewModel?.changeNickname()
    }
    
    private func changePassword() {
        self.viewModel?.changePassword()
    }
    
    private func logout() {
        self.viewModel?.logout()
    }
}



