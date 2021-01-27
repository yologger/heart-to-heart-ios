import UIKit

class ProfileViewController: BaseTableViewController, StoryboardInstantiable {
    
    static var storyboard = AppStoryboard.profile
    var viewModel: ProfileViewModel?
    
    @IBOutlet weak var imageViewAvatar: UIImageView!
    @IBOutlet weak var labelNickname: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelPostValue: UILabel!
    @IBOutlet weak var labelFollowingValue: UILabel!
    @IBOutlet weak var labelFollowerValue: UILabel!
    @IBOutlet weak var viewStatisticContainer: UIView!
    
    @IBOutlet weak var switchToggleTheme: UISwitch!
    
    override func viewDidLoad() {
        setup()
        setupBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupUI()
    }
    
    private func setup() {
        
        guard let _viewModel = self.viewModel else { return }
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 200
        
        let currentTheme = ThemeManager.currentTheme()
        if (currentTheme == .Dark) {
            switchToggleTheme.isOn = true
        } else {
            switchToggleTheme.isOn = false
        }
        switchToggleTheme.addTarget(self, action: #selector(onClickSwitch(sender:)), for: UIControl.Event.valueChanged)
        
        self.imageViewAvatar.isUserInteractionEnabled = true
        self.imageViewAvatar.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onImageViewTapped)))
        
        _viewModel.fetchCurrentUserInformation()
    }
    
    @objc func onImageViewTapped() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: false, completion: nil)
    }
    
    private func setupBinding() {
        guard let _viewModel = self.viewModel else { return }
        
        _viewModel.nicknameObservable.subscribe { [weak self] (nickname) in
            if nickname == nil {
                self?.labelNickname.text = "Nickname"
            } else {
                self?.labelNickname.text = nickname
            }
        } onError: { error in
            
        } onCompleted: {
            
        } onDisposed: {
            
        }.disposed(by: self.disposeBag)
        
        _viewModel.emailObservable.subscribe { [weak self] (email) in
            if email == nil {
                self?.labelEmail.text = "Email"
            } else {
                self?.labelEmail.text = email
            }
        } onError: { error in
            
        } onCompleted: {
            
        } onDisposed: {
            
        }.disposed(by: self.disposeBag)
        
        _viewModel.avatarObservable.subscribe { [weak self] (url) in
            if url == nil {
                self?.imageViewAvatar.image = UIImage(named: "avatar_default.png")
            } else {
                guard let _url = url else { return }
                let fullUrl = URL(string: "\(Constant.API.AuthBaseUrl)/\(_url)")
                self?.imageViewAvatar.kf.setImage(with: fullUrl)
                
            }
        } onError: { error in
            
        } onCompleted: {
            
        } onDisposed: {
            
        }.disposed(by: self.disposeBag)
    }
    
    private func setupUI() {
        imageViewAvatar.layer.cornerRadius = imageViewAvatar.frame.width/3
        imageViewAvatar.clipsToBounds = true
        
        viewStatisticContainer.layer.cornerRadius = 16
        viewStatisticContainer.layer.borderWidth = 1
        viewStatisticContainer.layer.borderColor = AppColor.Grey.light.cgColor
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

extension ProfileViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: false) {
            let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            //  let info = info[UIImagePickerController.InfoKey.imageURL]
            //  print("info: \(info)")
            guard let _viewModel = self.viewModel else { return }
            _viewModel.updateAvatarImage(image: image)
            // self.imageViewAvatar.image = image
        }
    }
}

extension ProfileViewController: UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: false) { () in
            let alert = UIAlertController(title: "", message: "이미지 선택이 취소되었습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel))
            self.present(alert, animated: true, completion: nil)
        }
    }
}


