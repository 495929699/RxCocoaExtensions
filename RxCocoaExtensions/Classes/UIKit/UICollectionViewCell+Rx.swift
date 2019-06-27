//
//  UICollectionViewCell+Rx.swift
//  Pods-RxCocoaExtensions_Example
//
//  Created by 荣恒 on 2019/5/26.
//

import UIKit
import RxSwift

public extension Reactive where Base : UICollectionViewCell {
    
    /// 重用信号
    var reuse : Observable<Void> {
        return methodInvoked(#selector(Base.prepareForReuse)).map({ _ in })
    }
    
}
