import UIKit
import RxSwift
import RxCocoa

class TestViewModel: BaseViewModel {
    
    private let getTestDataUseCase: GetTestDataUseCase
    
    init(getTestDataUseCase: GetTestDataUseCase) {
        self.getTestDataUseCase = getTestDataUseCase
    }
    
    func test() {
        getTestDataUseCase.execute().subscribe {
            print("ComCOM")
        }
    }
}
