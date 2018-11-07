//
//  DefaultReachabilityService.swift
//  RxPunk
//
//  Created by Rafael Ferreira on 5/24/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import class RxSwift.BehaviorSubject
import class RxSwift.Observable
import class ReachabilitySwift.Reachability
import class Dispatch.DispatchQueue

final class DefaultReachabilityService {
    fileprivate let _reachabilitySubject: BehaviorSubject<ReachabilityStatus>

    let _reachability: Reachability

    init() throws {
        guard let reachabilityRef = Reachability() else { throw ReachabilityServiceError.failedToCreate }

        let backgroundQueue = DispatchQueue(label: "reachability.wificheck")
        let reachabilitySubject = BehaviorSubject<ReachabilityStatus>(value: .unreachable)

        reachabilityRef.whenReachable = { reachability in
            backgroundQueue.async {
                reachabilitySubject.on(.next(.reachable(viaWiFi: reachabilityRef.isReachableViaWiFi)))
            }
        }

        reachabilityRef.whenUnreachable = { reachability in
            backgroundQueue.async {
                reachabilitySubject.on(.next(.unreachable))
            }
        }

        try reachabilityRef.startNotifier()
        
        _reachability = reachabilityRef
        _reachabilitySubject = reachabilitySubject
    }

    deinit {
        _reachability.stopNotifier()
    }
}

// MARK: ReachabilityService conforms

extension DefaultReachabilityService: ReachabilityService {
    var reachability: Observable<ReachabilityStatus> {
        return _reachabilitySubject.asObservable()
    }
}
