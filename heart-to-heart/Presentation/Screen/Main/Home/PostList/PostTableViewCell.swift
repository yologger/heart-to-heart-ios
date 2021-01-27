import UIKit
import ImageSlideshow

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageViewAvatar: UIImageView!
    @IBOutlet weak var labelNickname: UILabel!
    @IBOutlet weak var labelCreatedAt: UILabel!
    @IBOutlet weak var labelContent: UILabel!
    
    @IBOutlet weak var labelLike: UILabel!
    @IBOutlet weak var viewDivider: UIView!
    @IBOutlet weak var viewPostDivider: UIView!
    
    @IBOutlet weak var imageSlideshow: ImageSlideshow!
    
    let localSource = [
        BundleImageSource(imageString: "test.png"),
        BundleImageSource(imageString: "test.png"),
        BundleImageSource(imageString: "test.png"),
        BundleImageSource(imageString: "test.png"),
        BundleImageSource(imageString: "avatar1.jpg")
    ]
    
    // ViewDidLoad()
    override func awakeFromNib() {
        super.awakeFromNib()
        imageViewAvatar.layer.cornerRadius = 20
        imageViewAvatar.clipsToBounds = true
        labelContent.lineBreakMode = .byCharWrapping
        labelContent.numberOfLines = 0
        viewDivider.backgroundColor = AppColor.Grey.light
        viewPostDivider.backgroundColor = AppColor.Grey.dark
        
        // imageSlideshow.slideshowInterval = 5.0
        imageSlideshow.pageIndicatorPosition = .init(horizontal: .center, vertical: .bottom)
        imageSlideshow.contentScaleMode = UIViewContentMode.scaleAspectFill
        
        
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = AppColor.Primary.normal
        pageControl.pageIndicatorTintColor = AppColor.White.normal
        imageSlideshow.pageIndicator = pageControl
        
        imageSlideshow.activityIndicator = DefaultActivityIndicator()
        imageSlideshow.delegate = self
        imageSlideshow.setImageInputs(localSource)
        
        
        //
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(PostTableViewCell.didTap))
        imageSlideshow.addGestureRecognizer(recognizer)
    }
    
    // ViewWillAppear
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    @objc func didTap() {
        // let fullScreenController = imageSlideshow.presentFullScreenController(from: self)
        // fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }
    
}

extension PostTableViewCell: ImageSlideshowDelegate {
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
        // print("current page:", page)
    }
}
