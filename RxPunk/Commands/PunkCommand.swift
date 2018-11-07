//
//  PunkCommand.swift
//  RxPunk
//
//  Created by Rafael Ferreira on 5/24/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

enum PunkCommand {
    case changeText(String)
    case loadMoreItems
    case punkReceivedResponseReceived(GetBeersResponse)
}
