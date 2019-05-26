//
//  UIResponder+Rx.swift
//  RxSwiftX
//
//  Created by Pircate on 2018/5/25.
//  Copyright © 2018年 Pircate. All rights reserved.
//

import RxSwift
import RxCocoa

public extension Reactive where Base: UIResponder {
    
    /// 注销第一响应者
    var becomeFirstResponder: Binder<Void> {
        return Binder(base) { responder, _ in
            responder.becomeFirstResponder()
        }
    }
    
    /// 成为第一响应者
    var resignFirstResponder: Binder<Void> {
        return Binder(base) { responder, _ in
            responder.resignFirstResponder()
        }
    }
}
