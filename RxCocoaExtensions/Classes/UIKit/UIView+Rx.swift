//
//  UIView+Rx.swift
//  Pods-RxCocoaExtensions_Example
//
//  Created by 荣恒 on 2019/5/26.
//

import UIKit
import RxSwift

public extension Reactive where Base : UIView {
    
    /// hook init(frame:) 方法
    var initialize : Observable<Void> {
        return methodInvoked(#selector(Base.init(frame:))).map({ _ in })
    }
    
}
