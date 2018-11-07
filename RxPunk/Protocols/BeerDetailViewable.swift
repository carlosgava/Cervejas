//
//  BeerDetailViewable.swift
//  RxPunk
//
//  Created by Rafael Ferreira on 5/24/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import class UIKit.UILabel
import class UIKit.UITableViewController

protocol BeerDetailViewable: BeerViewable {
    var taglineLabel: UILabel! { get set }
    var bitternessScaleLabel: UILabel! { get set }
    var descriptionLabel: UILabel! { get set }

    func setupDetail(beer: Beer)
}

// MARK: Default implementation

extension BeerDetailViewable where Self: UITableViewController {
    func setupDetail(beer: Beer) {
        title = beer.name
        taglineLabel.text = beer.tagline
        bitternessScaleLabel.text = "Bitterness Scale: \(beer.bitternessScale)"
        descriptionLabel.text = beer.description
    }
}
