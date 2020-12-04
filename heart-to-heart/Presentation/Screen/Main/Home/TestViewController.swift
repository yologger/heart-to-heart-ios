import UIKit
import RxSwift
import RxCocoa
import Alamofire
import Foundation

class TestViewController: BaseViewController, StoryboardInstantiable {
    
    static var storyboard: AppStoryboard = .test
    
    var viewModel: TestViewModel?
    
    @IBOutlet weak var testBtn: UIButton!
    
    override func viewDidLoad() {
        self.initBindig()
        self.initUI()
    }
    
    private func initBindig() {
        testBtn.rx.tap.subscribe {
            print("Hello World")
        }.disposed(by: disposeBag)
        
        testBtn.rx.tap.bind { [weak self] in
            self?.viewModel?.test()
        }.disposed(by: self.disposeBag)
    }
    
    private func initUI() {
        
    }
    
    private func onTap() {
        
    }
}
