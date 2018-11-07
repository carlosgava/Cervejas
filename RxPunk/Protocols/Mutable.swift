//
//  Mutable.swift
//  RxPunk
//
//  Created by Rafael Ferreira on 5/24/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

/// These are kind of "Swift" lenses. We don't need to generate a lot of code this way and can just use Swift `var`.
protocol Mutable {
}

extension Mutable {
    func mutateOne<T>(transform: (inout Self) -> T) -> Self {
        var newSelf = self
        _ = transform(&newSelf)
        return newSelf
    }

    func mutate(transform: (inout Self) -> ()) -> Self {
        var newSelf = self
        transform(&newSelf)
        return newSelf
    }

    func mutate(transform: (inout Self) throws -> ()) rethrows -> Self {
        var newSelf = self
        try transform(&newSelf)
        return newSelf
    }
}