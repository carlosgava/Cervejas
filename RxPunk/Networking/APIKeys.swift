//
//  APIKeys.swift
//  RxPunk
//
//  Created by Rafael Ferreira on 5/24/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import struct Foundation.URL

enum APIKeys: String {
    case alcoholLevel = "abv"
    case bitternessScale = "ibu"
    case description
    case imageURL = "image_url"
    case name
    case tagline
}

// MARK: Computed variables

extension APIKeys {
    var $: String {
        return rawValue
    }
}

// MARK: Static closures

extension APIKeys {
    static let getBeers: (Int, String) -> URL? = { page, beerName in
        let beerName = beerName.isEmpty ? beerName : "&beer_name=\(beerName.replacingOccurrences(of: " ", with: "_"))"
        let urlString = "https://api.punkapi.com/v2/beers?page=\(page)\(beerName)"
        
        return URL(string: urlString)
    }
}
