//
//  PunkAPIError.swift
//  RxPunk
//
//  Created by Rafael Ferreira on 5/24/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

enum PunkAPIError: Error {
    case offline
    case limitReached
    case badRequest
    case networkError
}
