 //
//  Operators.swift
//  RxExample
//
//  Created by Krunoslav Zaher on 12/6/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

import RxSwift
import RxCocoa
#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

// MARK: - 双向绑定

 /// 双向绑定操作符
 infix operator <-> : DefaultPrecedence

#if os(iOS)
public func nonMarkedText(_ textInput: UITextInput) -> String? {
    let start = textInput.beginningOfDocument
    let end = textInput.endOfDocument

    guard let rangeAll = textInput.textRange(from: start, to: end),
        let text = textInput.text(in: rangeAll) else {
            return nil
    }

    guard let markedTextRange = textInput.markedTextRange else {
        return text
    }

    guard let startRange = textInput.textRange(from: start, to: markedTextRange.start),
        let endRange = textInput.textRange(from: markedTextRange.end, to: end) else {
        return text
    }

    return (textInput.text(in: startRange) ?? "") + (textInput.text(in: endRange) ?? "")
}

public func <-> <Base>(textInput: TextInput<Base>, relay: BehaviorRelay<String>) -> Disposable {
    let bindToUIDisposable = relay.bind(to: textInput.text)

    let bindToRelay = textInput.text
        .subscribe(onNext: { [weak base = textInput.base] n in
            guard let base = base else {
                return
            }

            let nonMarkedTextValue = nonMarkedText(base)

            /**
             In some cases `textInput.textRangeFromPosition(start, toPosition: end)` will return nil even though the underlying
             value is not nil. This appears to be an Apple bug. If it's not, and we are doing something wrong, please let us know.
             The can be reproed easily if replace bottom code with 
             
             if nonMarkedTextValue != relay.value {
                relay.accept(nonMarkedTextValue ?? "")
             }

             and you hit "Done" button on keyboard.
             */
            if let nonMarkedTextValue = nonMarkedTextValue, nonMarkedTextValue != relay.value {
                relay.accept(nonMarkedTextValue)
            }
        }, onCompleted:  {
            bindToUIDisposable.dispose()
        })

    return Disposables.create(bindToUIDisposable, bindToRelay)
}
#endif

public func <-> <T>(property: ControlProperty<T>, relay: BehaviorRelay<T>) -> Disposable {
    let bindToUIDisposable = relay.bind(to: property)
    let bindToRelay = property
        .subscribe(onNext: { n in
            relay.accept(n)
        }, onCompleted:  {
            bindToUIDisposable.dispose()
        })

    return Disposables.create(bindToUIDisposable, bindToRelay)
}


/// 通用序列双向绑定
public func <-> <T,S : ObservableType & ObserverType>(property: ControlProperty<T>, subject: S) -> Disposable where S.E == T  {
    
    let bindToUIDisposable = subject.bind(to: property)
    let bindToRelay = property
        .subscribe(onNext: { n in
            subject.onNext(n)
        }, onCompleted:  {
            bindToUIDisposable.dispose()
        })
    
    return Disposables.create(bindToUIDisposable, bindToRelay)
}

 // MARK: - 单向绑定
 
 ///单向操作符
 infix operator ~> : DefaultPrecedence

 /// 单向绑定 source bindTo target
 public func ~><S : ObservableType, T : ObserverType>(source : S, target : T) -> Disposable where S.E == T.E {
    return source.bind(to: target)
 }
 
 public func ~><S : ObservableType, T : ObserverType>(source : S, target : T) -> Disposable where S.E? == T.E {
    return source.bind(to: target)
 }

  // MARK: - Disposable相关
 /// 定义优先级组
 precedencegroup DisposePrecedence {
    //higherThan: XXX                   // 优先级,比XXX运算高
    lowerThan: DefaultPrecedence        // 优先级,比DefaultPrecedence运算低
    associativity: none                 // 结合方向:left, right or none
    assignment: false                   // true=赋值运算符,false=非赋值运算符
 }
 
 infix operator => : DisposePrecedence
 /// 绑定生命周期
 public func =>(l : Disposable, r : DisposeBag) {
    l.disposed(by: r)
 }


