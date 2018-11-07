//
//  PunkAPI.swift
//  RxPunk
//
//  Created by Rafael Ferreira on 5/24/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import struct Foundation.URL
import class RxSwift.Observable

typealias GetBeersResponse = Result<(beers: [Beer], hasNext: Bool), PunkAPIError>

protocol PunkAPI {
    func getBeers(at: URL) -> Observable<GetBeersResponse>
}
