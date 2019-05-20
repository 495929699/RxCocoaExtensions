//
//  Bind.swift
//  RxCocoaExtensions
//
//  Created by 荣恒 on 2019/4/19.
//

import RxSwift
import RxCocoa


// MARK: - 单向绑定
///单向操作符
infix operator ~> : DefaultPrecedence

extension ObservableType {
    
    public static func ~> <O>(observable: Self, observer: O) -> Disposable where O: ObserverType, O.E == Self.E {
        return observable.bind(to: observer)
    }
    
    public static func ~> <O>(observable: Self, observer: O) -> Disposable where O : ObserverType, O.E == Self.E?  {
        return observable.bind(to: observer)
    }
    
}

extension ObservableType {
    
    public static func ~> <O>(observable: Self, observers: [O]) -> Disposable where O: ObserverType, O.E == Self.E {
        return observable.bind(to: observers)
    }
    
    public static func ~> <O>(observable: Self, observers: [O]) -> Disposable where O : ObserverType, O.E == Self.E?  {
        return observable.bind(to: observers)
    }
    
    func bind<O>(to observers: [O]) -> Disposable where O: ObserverType, Self.E == O.E {
        let shared = self.share()
        let disposables = observers.map { shared.bind(to: $0) }
        return CompositeDisposable(disposables: disposables)
    }
    
    func bind<O>(to observers: [O]) -> Disposable where O: ObserverType, Self.E? == O.E {
        let shared = self.share()
        let disposables = observers.map { shared.bind(to: $0) }
        return CompositeDisposable(disposables: disposables)
    }
}
