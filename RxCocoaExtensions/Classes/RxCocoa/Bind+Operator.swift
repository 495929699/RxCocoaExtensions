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

// MARK: - Observable
extension ObservableType {
    
    public static func ~> <O>(observable: Self, observer: O) -> Disposable where O: ObserverType, Self.Element == O.Element {
        return observable.bind(to: observer)
    }
    
    public static func ~> <O>(observable: Self, observer: O) -> Disposable where O : ObserverType, Self.Element? == O.Element  {
        return observable.bind(to: observer)
    }
    
    public static func ~> <O>(observable: Self, observers: [O]) -> Disposable where O: ObserverType, Self.Element == O.Element {
        return observable.bind(to: observers)
    }
    
    public static func ~> <O>(observable: Self, observers: [O]) -> Disposable where O : ObserverType, Self.Element? == O.Element  {
        return observable.bind(to: observers)
    }
}

extension ObservableType {
    func bind<O>(to observers: [O]) -> Disposable where O: ObserverType, Self.Element == O.Element {
        let shared = self.share()
        let disposables = observers.map { shared.bind(to: $0) }
        return CompositeDisposable(disposables: disposables)
    }
    
    func bind<O>(to observers: [O]) -> Disposable where O: ObserverType, Self.Element? == O.Element {
        let shared = self.share()
        let disposables = observers.map { shared.bind(to: $0) }
        return CompositeDisposable(disposables: disposables)
    }
}


// MARK: - Driver
extension SharedSequenceConvertibleType where Self.SharingStrategy == RxCocoa.DriverSharingStrategy {
    
    public static func ~> <O>(observable: Self, observer: O) -> Disposable where O : ObserverType, Self.Element == O.Element {
        return observable.drive(observer)
    }
    
    public static func ~> <O>(observable: Self, observer: O) -> Disposable where O : ObserverType, Self.Element? == O.Element  {
        return observable.drive(observer)
    }
    
    public static func ~> <O>(observable: Self, observers: [O]) -> Disposable where O : ObserverType, Self.Element == O.Element {
        return observable.drive(observers)
    }
    
    public static func ~> <O>(observable: Self, observers: [O]) -> Disposable where O : ObserverType, Self.Element? == O.Element {
        return observable.drive(observers)
    }

}

extension SharedSequenceConvertibleType where Self.SharingStrategy == RxCocoa.DriverSharingStrategy {
    func drive<O>(_ observers: [O]) -> Disposable where O: ObserverType, Self.Element == O.Element {
        let disposables = observers.map { self.drive($0) }
        return CompositeDisposable(disposables: disposables)
    }
    func drive<O>(_ observers: [O]) -> Disposable where O: ObserverType, Self.Element? == O.Element {
        let disposables = observers.map { self.drive($0) }
        return CompositeDisposable(disposables: disposables)
    }
}
