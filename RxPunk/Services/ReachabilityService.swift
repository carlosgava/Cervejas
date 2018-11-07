//
//  ReachabilityService.swift
//  RxPunk
//
//  Created by Rafael Ferreira on 5/24/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import class RxSwift.Observable

protocol ReachabilityService {
    var reachability: Observable<ReachabilityStatus> { get }
}
