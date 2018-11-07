//
//  StoryboardSegue.swift
//  RxPunk
//
//  Created by Rafael Ferreira on 5/24/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

enum StoryboardSegue {
    case showDetail(Beer)
}

// MARK: CustomStringConvertible conforms

extension StoryboardSegue: CustomStringConvertible {
    var description: String {
        return "showDetail"
    }
}
