//
//  Version.swift
//  RxPunk
//
//  Created by Rafael Ferreira on 5/24/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

/**
 When something unrelated changes, we don't want to reload table view.
 */
struct Version<Value> {
    fileprivate let unique: Unique

    // MARK: Constants

    let value: Value

    // MARK: Initializable

    init(_ value: Value) {
        self.unique = Unique()
        self.value = value
    }
}

// MARK: Hashable conforms

extension Version: Hashable {
    var hashValue: Int {
        return unique.hash
    }

    public static func ==(lhs: Version<Value>, rhs: Version<Value>) -> Bool {
        return lhs.unique == rhs.unique
    }
}

// MARK: Functions

extension Version {
    func mutate(transform: (inout Value) -> ()) -> Version<Value> {
        var newSelf = self.value

        transform(&newSelf)

        return Version(newSelf)
    }

    func mutate(transform: (inout Value) throws -> ()) rethrows -> Version<Value> {
        var newSelf = self.value

        try transform(&newSelf)

        return Version(newSelf)
    }
}
