//
//  UIImageView.swift
//  RxPunk
//
//  Created by Rafael Ferreira on 5/28/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import Shimmer

extension UIImageView {
    func getShimmeringView() -> FBShimmeringView {
        guard let superview = superview else { fatalError("First add your UIImageView inside other view") }

        let shimmeringView = FBShimmeringView(frame: superview.bounds)

        superview.addSubview(shimmeringView)

        shimmeringView.contentView = self
        shimmeringView.isShimmering = true

        return shimmeringView
    }

    func set(URL: URL) {
        let shimmer = getShimmeringView()

        kf.setImage(with: URL, placeholder: #imageLiteral(resourceName: "BrewDog"), options: [.transition(.fade(0.35))]) { _ in
            shimmer.isShimmering = false
        }
    }
}
