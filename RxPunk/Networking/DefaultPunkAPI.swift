//
//  DefaultPunkAPI.swift
//  RxPunk
//
//  Created by Rafael Ferreira on 5/24/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//
import struct Foundation.Data
import class Foundation.HTTPURLResponse
import class Foundation.JSONSerialization
import struct Foundation.URL
import struct Foundation.URLRequest
import class Foundation.URLSession
import RxCocoa
import protocol RxSwift.ImmediateSchedulerType
import class RxSwift.Observable

struct DefaultPunkAPI {
    let backgroundWorker: ImmediateSchedulerType
    let itemsPerPage: Int
    let reachabilityService: ReachabilityService
    let urlSession: URLSession
}

// MARK: PunkAPI conforms

extension DefaultPunkAPI: PunkAPI {
    func getBeers(at url: URL) -> Observable<GetBeersResponse> {
        let request = URLRequest(url: url)
        let limit = itemsPerPage

        return urlSession.rx.response(request: request)
            .observeOn(backgroundWorker)
            .map({ httpResponse, data -> GetBeersResponse in
                guard httpResponse.statusCode < 400 else { return .failure(.badRequest) }

                let jsonRoot = try DefaultPunkAPI.parse(httpResponse: httpResponse, data: data)

                guard let json = jsonRoot as? [[String: Any]] else { fatalError() }

                let beers = try Beer.parse(json: json)
                let hasNext = beers.count == limit

                return .success(beers: beers, hasNext: hasNext)
            })
            .retryOnBecomesReachable(.failure(.offline), reachabilityService: reachabilityService)
    }
}

// MARK: Private functions

private extension DefaultPunkAPI {
    static func parse(httpResponse: HTTPURLResponse, data: Data) throws -> Any {
        let validStatusCodes = 200 ..< 300

        guard validStatusCodes ~= httpResponse.statusCode else { fatalError() }

        return try JSONSerialization.jsonObject(with: data, options: [])
    }
}

// MARK: Private Beer functions

private extension Beer {
    static func parse(json: [[String: Any]]) throws -> [Beer] {
        return json.map({ beer in
            guard let description = beer[APIKeys.description.rawValue] as? String,
            let imageURLString = beer[APIKeys.imageURL.rawValue] as? String,
            let imageURL = URL(string: imageURLString),
            let name = beer[APIKeys.name.rawValue] as? String,
            let tagline = beer[APIKeys.tagline.rawValue] as? String else {
                    fatalError()
            }
            
            let alcoholLevel = (beer[APIKeys.alcoholLevel.rawValue] as? Double) ?? 0
            let bitternessScale = (beer[APIKeys.bitternessScale.rawValue] as? Float) ?? 0

            return Beer(alcoholLevel: alcoholLevel,
            bitternessScale: bitternessScale,
            description: description,
            imageURL: imageURL,
            name: name,
            tagline: tagline)
        })
    }
}
