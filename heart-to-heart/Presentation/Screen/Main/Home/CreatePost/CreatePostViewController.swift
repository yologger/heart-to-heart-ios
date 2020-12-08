import UIKit
import RxSwift
import RxCocoa

class CreatePostViewController: BaseViewController, StoryboardInstantiable {
    
    static var storyboard = AppStoryboard.createPost
    
    var viewModel: CreatePostViewModel?
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var galleryButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var contentTextView: UITextView!
    
    override func viewDidLoad() {
        self.initBinding()
        self.initUI()
    }
    
    private func initBinding() {
        guard let viewModel = self.viewModel else { return }
        
        self.closeButton.rx.tap
            .bind { [weak self] in self?.viewModel?.closeCreatePost() }
            .disposed(by: self.disposeBag)
        
        self.cameraButton.rx.tap
            .bind { [weak self] in self?.viewModel?.showCamera() }
            .disposed(by: self.disposeBag)
        
        self.galleryButton.rx.tap
            .bind { [weak self] in self?.viewModel?.showGallery() }
            .disposed(by: self.disposeBag)
        
        self.createButton.rx.tap
            .bind { [weak self] in self?.viewModel?.createPost() }
            .disposed(by: self.disposeBag)
        
        self.contentTextView.rx.text.orEmpty
            .bind(to: viewModel.content)
            .disposed(by: self.disposeBag)
    }
    
    private func initUI() {
        self.initCloseButton()
        self.initCameraButton()
        self.initGalleryButton()
        self.initCreateButton()
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
    
    private func initGalleryButton() {
        self.galleryButton.setTitle("", for: .normal)
        let orignalImage = UIImage(named: "album_icon")
        let tintedImage = orignalImage?.withRenderingMode(.alwaysTemplate)
        galleryButton.setImage(tintedImage, for: .normal)
        galleryButton.tintColor = .black
    }
    
    private func initCreateButton() {
        self.createButton.setTitle("", for: .normal)
        let orignalImage = UIImage(named: "create_icon")
        let tintedImage = orignalImage?.withRenderingMode(.alwaysTemplate)
        createButton.setImage(tintedImage, for: .normal)
        createButton.tintColor = .black
    }
    
}
