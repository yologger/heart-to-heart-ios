import RxSwift

class LogInUseCase {
    func execute() -> Observable<Bool> {
        return Observable<Bool>.create { emitter -> Disposable in
            emitter.onNext(true)
            emitter.onCompleted()
            return Disposables.create()
        }
    }
}

//Observable<Int>.create({(observer) -> Disposable in
//    observer.onNext(1)        // 1을 포함한 next 이벤트를 발생시킨다.
//    observer.on(.next(2))
//    observer.onNext(3)
//    observer.onNext(4)
//    observer.onCompleted()
//    return Disposables.create()
//}).subscribe(
//    onNext: { data in print(data) },
//    onCompleted: { print("Completed") }
//)
