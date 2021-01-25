import UIKit
import RxSwift
import RxCocoa
import TLPhotoPicker

class CreatePostViewController: BaseViewController, StoryboardInstantiable {
    
    static var storyboard = AppStoryboard.createPost
    
    var viewModel: CreatePostViewModel?
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var openGalleryButton: UIButton!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viewHeader: UIView!
    
    override func viewDidLoad() {
        self.initBinding()
        self.initUI()
    }
    
    private func initBinding() {
        guard let viewModel = self.viewModel else { return }
        
        self.closeButton.rx.tap
            .bind { [weak self] in self?.viewModel?.closeCreatePost() }
            .disposed(by: self.disposeBag)
        
        //        self.galleryButton.rx.tap
        //            .bind { [weak self] in self?.viewModel?.showGallery() }
        //            .disposed(by: self.disposeBag)
        
        self.createButton.rx.tap
            .bind { [weak self] in self?.viewModel?.createPost() }
            .disposed(by: self.disposeBag)
        
        self.contentTextView.rx.text.orEmpty
            .bind(to: viewModel.content)
            .disposed(by: self.disposeBag)
        
        viewModel.selectedImagesObservable.subscribe { [weak self] images in
            self?.collectionView.reloadData()
        }.disposed(by: self.disposeBag)
    }
    
    private func initUI() {
        viewHeader.backgroundColor = AppColor.Primary.normal
        self.initCloseButton()
        self.initCreateButton()
        self.initCollectionView()
        self.initOpenGalleryButton()
    }
    
    @IBAction func openGallery(_ sender: Any) {
        let photosPickerViewController = TLPhotosPickerViewController()
        photosPickerViewController.delegate = self
        self.present(photosPickerViewController, animated: true, completion: nil)
    }
    
    private func initOpenGalleryButton() {
        openGalleryButton.backgroundColor = AppColor.White.normal
        openGalleryButton.tintColor = AppColor.Primary.normal
        openGalleryButton.layer.borderColor = AppColor.Primary.normal.cgColor
        openGalleryButton.layer.borderWidth = 1
        openGalleryButton.layer.cornerRadius = 16
    }
    
    private func initCloseButton() {
        self.closeButton.setTitle("", for: .normal)
        let orignalImage = UIImage(named: "clear_icon")
        let tintedImage = orignalImage?.withRenderingMode(.alwaysTemplate)
        closeButton.setImage(tintedImage, for: .normal)
        closeButton.tintColor = AppColor.White.normal
    }
    
    private func initCreateButton() {
        self.createButton.setTitle("", for: .normal)
        let orignalImage = UIImage(named: "create_icon")
        let tintedImage = orignalImage?.withRenderingMode(.alwaysTemplate)
        // createButton.setImage(tintedImage, for: .normal)
        createButton.setTitle("DONE", for: .normal)
        createButton.tintColor = AppColor.White.normal
    }
    
    private func initCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.collectionViewLayout = flowLayout
        self.collectionView.register(UINib(nibName: "ImageItemWithClearButton", bundle: nil), forCellWithReuseIdentifier: "ImageItemWithClearButton")
    }
}

extension CreatePostViewController: TLPhotosPickerViewControllerDelegate {
    
    func shouldDismissPhotoPicker(withTLPHAssets: [TLPHAsset]) -> Bool {
        print("Images!!!!!")
       //  print(withTLPHAssets)
        // for (idx, asset) in withTLPHAssets.enumerated() {
            // print("image \(idx): \(asset)")
//            print("ext \(idx): \(asset.extType().rawValue)")
//            print("original file name \(idx): \(asset.originalFileName)")
        // }
        
        guard let viewModel = self.viewModel else { return false }
        let selectedImages = withTLPHAssets.map { withTLPHAsset in
            return withTLPHAsset.fullResolutionImage
        }
        viewModel.addImages(images: selectedImages)
        return true
    }
    
    func photoPickerDidCancel() {
        print("cancel")
    }
    
    func handleNoAlbumPermissions(picker: TLPhotosPickerViewController) {
        print("handle no album permission")
    }
    
    func handleNoCameraPermissions(picker: TLPhotosPickerViewController) {
        print("handle no camera permission")
    }
}

extension CreatePostViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        guard let vm = self.viewModel else { return 0 }
//        return vm.selectedImages.count
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageItemWithClearButton", for: indexPath) as! ImageItemWithClearButton
        // cell.imageViewAvatar.image = viewModel?.selectedImages[indexPath.row]
        return cell
    }
    
}


extension CreatePostViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height, height: collectionView.frame.height)
    }
}
