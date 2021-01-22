import UIKit

class ProfileViewController: UITableViewController, StoryboardInstantiable {
    
    static var storyboard = AppStoryboard.profile
    var viewModel: ProfileViewModel?
    
    @IBOutlet weak var themeToggleButton: UISwitch!
    
    lazy var imageViewAvatar: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = imageView.frame.height/4
        imageView.image = UIImage(named: "avatar_default.png")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override func viewDidLoad() {
        initBinding()
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 200
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initUI()
    }
    
    private func initBinding() {
        
    }
    
    private func initUI() {
        initThemeToggleButton()
        initImageViewAvatar()
    }
    
    private func initImageViewAvatar() {
        self.view.addSubview(imageViewAvatar)
        imageViewAvatar.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(100)
        }
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
        case 2: self.changeTheme()
        case 3: self.logout()
        default:
            print("Error")
        }
    }
    
    private func initThemeToggleButton() {
        let currentTheme = ThemeManager.currentTheme()
        if (currentTheme == .Dark) {
            themeToggleButton.isOn = true
        } else {
            themeToggleButton.isOn = false
        }
        themeToggleButton.addTarget(self, action: #selector(onClickSwitch(sender:)), for: UIControl.Event.valueChanged)
    }
    
    @objc func onClickSwitch(sender: UISwitch) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.toggleTheme(isDark: sender.isOn)
        
    }
   
    private func changeNickname() {
        self.viewModel?.changeNickname()
    }
    
    private func changePassword() {
        self.viewModel?.changePassword()
    }
    
    private func changeTheme() {
        
    }
    
    private func logout() {
        self.viewModel?.logout()
    }
}



