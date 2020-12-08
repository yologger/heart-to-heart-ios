import RxSwift


protocol BaseUseCase {
    associatedtype Result
    func call() -> Observable<Result>
    func execute() -> Observable<Result>
}

extension BaseUseCase {
    func execute() -> Observable<Result> {
        return call()
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .default))
            .observe(on: MainScheduler.instance)
    }
}



final class GetAllUserUseCase {
    
}
//
//extension GetAllUserUseCase: BaseUseCase {
//
//    typealias T = String
//
//    func call() -> Observable<T> {
//        Observable.create { observer -> Disposable in
//            observer.onNext("Hello")
//            return Disposables.create()
//        }
//    }
//}

extension GetAllUserUseCase: BaseUseCase {
    
    func call() -> Observable<String> {
        Observable.create { observer -> Disposable in
            observer.onNext("true")
            return Disposables.create()
        }
    }
}
