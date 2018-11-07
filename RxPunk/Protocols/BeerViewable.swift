//
//  BeerViewable.swift
//  RxPunk
//
//  Created by Rafael Ferreira on 5/24/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import Kingfisher
import class UIKit.UIImageView
import class UIKit.UILabel

protocol BeerViewable: class {
    var beerImageView: UIImageView! { get set }
    var nameLabel: UILabel! { get set }
    var alcoholLevelLabel: UILabel! { get set }

    func setup(beer: Beer)
}

// MARK: Default implementation

extension BeerViewable {
    func setup(beer: Beer) {
        
        beerImageView.set(URL: beer.imageURL)
        nameLabel.text = beer.name
        alcoholLevelLabel.text = "Alcohol Level: \(beer.alcoholLevel)"
    }
}
