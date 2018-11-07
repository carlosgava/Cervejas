//
//  ReachabilityStatus.swift
//  RxPunk
//
//  Created by Rafael Ferreira on 5/24/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

public enum ReachabilityStatus {
    case reachable(viaWiFi: Bool)
    case unreachable
}

// MARK: Computed variables

extension ReachabilityStatus {
    var reachable: Bool {
        switch self {
        case .reachable: return true
        case .unreachable: return false
        }
    }
}
