//
//  Card.swift
//  concentration
//
//  Created by Roman Zakharov on 08/09/2019.
//  Copyright © 2019 Роман Захаров. All rights reserved.
//

import Foundation

struct Card
{
    var isFaceUp = false
    var wasPickedBefore = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIndetifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIndetifier()
    }
}
