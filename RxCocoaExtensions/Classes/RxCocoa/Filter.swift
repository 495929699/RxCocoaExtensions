//
//  Filter.swift
//  RxCocoaExtensions
//
//  Created by 荣恒 on 2019/4/19.
//

import RxCocoa
import RxSwift

public extension SharedSequence {
    
    /// 过滤掉nil
    func filterNil<T>() -> SharedSequence<S,T> where E == Optional<T> {
        return filter({ $0 != nil }).map({ $0! })
    }
    
}
