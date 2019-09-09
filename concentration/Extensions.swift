//
//  Extensions.swift
//  concentration
//
//  Created by Roman Zakharov on 10/09/2019.
//  Copyright © 2019 Роман Захаров. All rights reserved.
//

import Foundation

extension Int {
    
    var arc4random: Int {
        return Int(arc4random_uniform(UInt32(self)))
    }
}
