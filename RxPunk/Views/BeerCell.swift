//
//  BeerCell.swift
//  RxPunk
//
//  Created by Rafael Ferreira on 5/24/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import UIKit.UIImageView
import UIKit.UILabel
import class UIKit.UITableViewCell

final class BeerCell: UITableViewCell, BeerViewable {
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alcoholLevelLabel: UILabel!
}
