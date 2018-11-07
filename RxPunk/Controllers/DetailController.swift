//
//  DetailController.swift
//  RxPunk
//
//  Created by Rafael Ferreira on 5/24/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import struct UIKit.CGFloat
import struct UIKit.IndexPath
import class UIKit.UIImageView
import class UIKit.UILabel
import class UIKit.UITableView
import var UIKit.UITableViewAutomaticDimension
import class UIKit.UITableViewController

final class DetailController: UITableViewController, BeerDetailViewable {
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var alcoholLevelLabel: UILabel!
    @IBOutlet weak var bitternessScaleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: File private variables
    
    fileprivate var beer: Beer? = nil
}

// MARK: Functions

extension DetailController {
    func set(beer: Beer) {
        self.beer = beer
    }
}

// MARK: UIViewControllers functions

extension DetailController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

// MARK: UITableViewDelegate conforms

extension DetailController {
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

// MARK: Private functions

private extension DetailController {
    func setupUI() {
        guard let beer = beer else { return }
        
        setup(beer: beer)
        setupDetail(beer: beer)
    }
}
