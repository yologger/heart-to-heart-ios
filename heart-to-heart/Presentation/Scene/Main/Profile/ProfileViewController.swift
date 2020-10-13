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
        print("changeNickname")
    }
    
    private func changePassword() {
        print("changePassword")
    }
    
    private func logout() {
        print("logout")
    }
}



