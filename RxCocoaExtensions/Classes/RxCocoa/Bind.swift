//
//  Bind.swift
//  RxCocoaExtensions
//
//  Created by 荣恒 on 2019/4/19.
//

import RxCocoa
import RxSwift

extension ObservableType {
    
    public func bind(to relaies: [BehaviorRelay<E?>]) -> Disposable {
        let shared = self.share()
        let disposables = relaies.map({ shared.bind(to: $0) })
        return Disposables.create(disposables)
    }
    
    public func bind(to relaies: [BehaviorRelay<E>]) -> Disposable {
        let shared = self.share()
        let disposables = relaies.map({ shared.bind(to: $0) })
        return Disposables.create(disposables)
    }
    
}
