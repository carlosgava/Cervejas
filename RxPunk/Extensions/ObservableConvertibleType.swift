//
//  ObservableConvertibleType.swift
//  RxPunk
//
//  Created by Rafael Ferreira on 5/24/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import class RxSwift.Observable
import protocol RxSwift.ObservableConvertibleType

extension ObservableConvertibleType {
    func retryOnBecomesReachable(_ valueOnFailure:E, reachabilityService: ReachabilityService) -> Observable<E> {
        return self.asObservable()
            .catchError({ error -> Observable<E> in
                reachabilityService.reachability
                    .skip(1)
                    .filter({ $0.reachable })
                    .flatMap({ _ in Observable.error(error) })
                    .startWith(valueOnFailure)
            })
            .retry()
    }
}
