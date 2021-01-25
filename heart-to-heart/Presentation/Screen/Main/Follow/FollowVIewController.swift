import UIKit
import RxSwift
import XLPagerTabStrip

class FollowViewController: ButtonBarPagerTabStripViewController, StoryboardInstantiable {
    
    static var storyboard = AppStoryboard.follow

    private let disposeBase = DisposeBag()
    var viewModel: FollowViewModel?
    
    let tabbarSelectedColor = AppColor.Primary.light
    let tabbarUnselectedColor = AppColor.Grey.light
    
    override func viewDidLoad() {
        
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = tabbarSelectedColor
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = AppColor.Grey.light
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = self?.tabbarUnselectedColor
            newCell?.label.textColor = self?.tabbarSelectedColor
        }
        
        // self.navigationController?.isNavigationBarHidden = true
        
        
        super.viewDidLoad()
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let followingViewController = FollowingViewController.instantiate()
        let followerViewController = FollowerViewController.instantiate()
        return [followingViewController, followerViewController]
    }
}
