//
//  UIScrollView+Rx.swift
//  RxSwiftX
//
//  Created by Pircate on 2018/5/25.
//  Copyright © 2018年 Pircate. All rights reserved.
//

import RxSwift
import RxCocoa

public extension Reactive where Base : UIScrollView {
    
    func reachedBottom(withOffset offset: CGFloat = 0.0) -> ControlEvent<Bool> {
        let observable = contentOffset
            .map { [weak base] contentOffset -> Bool in
                guard let scrollView = base else { return false }
                let visibleHeight = scrollView.frame.height
                    - scrollView.contentInset.top
                    - scrollView.contentInset.bottom
                let y = contentOffset.y + scrollView.contentInset.top
                let threshold = max(offset, scrollView.contentSize.height - visibleHeight)
                
                return y > threshold
        }
        
        return ControlEvent(events: observable.distinctUntilChanged())
    }
    
}

public extension Reactive where Base: UIScrollView {
    
    var bounces: Binder<Bool> {
        return Binder(base) { scrollView, bounces in
            scrollView.bounces = bounces
        }
    }
}
