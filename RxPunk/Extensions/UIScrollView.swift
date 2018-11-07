//
//  UIScrollView.swift
//  RxPunk
//
//  Created by Rafael Ferreira on 5/24/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import UIKit

extension UIScrollView {
    public var isNearBottomEdge: Bool {
        let edgeOffset: CGFloat = 20

        return contentOffset.y + frame.size.height + edgeOffset > contentSize.height
    }
}
