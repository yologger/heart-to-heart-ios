import UIKit
import RxSwift
import RxCocoa

class CreatePostViewController: UIViewController, StoryboardInstantiable {
    
    static var storyboard = AppStoryboard.createPost
    
    private let disposeBag = DisposeBag()
    var viewModel: CreatePostViewModel?
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    
    override func viewDidLoad() {
        self.initButtons()
    }
    
    private func initButtons() {
        self.initCloseButton()
        self.initCameraButton()
        self.initPhotoButton()
        self.initCreateButton()
        self.bindUI()
    }
    
    private func initCloseButton() {
        self.closeButton.setTitle("", for: .normal)
        let orignalImage = UIImage(named: "clear_icon")
        let tintedImage = orignalImage?.withRenderingMode(.alwaysTemplate)
        closeButton.setImage(tintedImage, for: .normal)
        closeButton.tintColor = .black
    }
    
    private func initCameraButton() {
        self.cameraButton.setTitle("", for: .normal)
        let orignalImage = UIImage(named: "camera_icon")
        let tintedImage = orignalImage?.withRenderingMode(.alwaysTemplate)
        cameraButton.setImage(tintedImage, for: .normal)
        cameraButton.tintColor = .black
    }
    
    private func initPhotoButton() {
        self.photoButton.setTitle("", for: .normal)
        let orignalImage = UIImage(named: "album_icon")
        let tintedImage = orignalImage?.withRenderingMode(.alwaysTemplate)
        photoButton.setImage(tintedImage, for: .normal)
        photoButton.tintColor = .black
    }
    
    private func initCreateButton() {
        self.createButton.setTitle("", for: .normal)
        let orignalImage = UIImage(named: "create_icon")
        let tintedImage = orignalImage?.withRenderingMode(.alwaysTemplate)
        createButton.setImage(tintedImage, for: .normal)
        createButton.tintColor = .black
    }
    
    private func bindUI() {
        guard let viewModel = self.viewModel else { return }
        
        self.closeButton.rx.tap
            .bind { [weak self] in self?.viewModel?.closeCreatePost() }
            .disposed(by: self.disposeBag)
    }
}
