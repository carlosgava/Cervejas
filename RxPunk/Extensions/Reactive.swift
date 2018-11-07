//
//  Reactive.swift
//  RxPunk
//
//  Created by Rafael Ferreira on 5/24/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import class RxCocoa.UIBindingObserver
import class RxSwift.Observable
import struct RxSwift.Reactive
import class UIKit.UITableView
import class UIKit.UIViewController

extension Reactive where Base: UIViewController {
    var performSegue: UIBindingObserver<UIViewController, StoryboardSegue> {
        return UIBindingObserver(UIElement: base) { viewController, segue in
            switch segue {
            case .showDetail(let beer):
                viewController.performSegue(withIdentifier: segue.description, sender: beer)
            }
        }
    }
}

// MARK: UITableView computed variables

extension Reactive where Base: UITableView {
    var nextPageTrigger: Observable<Void> {
        return base.rx.contentOffset.flatMapLatest({ _ in
            return self.base.isNearBottomEdge ? Observable.just() : Observable.empty()
        })
    }
}
