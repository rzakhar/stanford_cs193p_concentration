//
//  Themes.swift
//  concentration
//
//  Created by Roman Zakharov on 08/09/2019.
//  Copyright © 2019 Роман Захаров. All rights reserved.
//

import UIKit

struct Theme: Equatable {
    var backgroundColor: UIColor
    var cardBackColor: UIColor
    var emoji: [String] = []
    
    init(backgroundColor: UIColor, cardBackColor: UIColor, _ emojiString: String) {
        self.backgroundColor = backgroundColor
        self.cardBackColor = cardBackColor
        self.emoji = Array(emojiString).map({ String($0) })
    }
}

let themes = [Theme(backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), cardBackColor: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), "🎃👻😈🍭🦇🧛🏻‍♀️🦉🕷🕸🍬⚰️🔮🎈✝️"),
    Theme(backgroundColor: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), cardBackColor: #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1), "🐶🐱🐭🐹🐰🦊🐻🐼🐨🐯🦁🐮🐷🐸🐵"),
    Theme(backgroundColor: #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), cardBackColor: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), "🍎🍐🍊🍋🍌🍉🍇🍓🍒🍑🥭🍍🥥🥝🍆"),
    Theme(backgroundColor: #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1), cardBackColor: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), "⚽️🏀🏈⚾️🎾🏐🏉🥏🎱🎲🎳🥌🥊🏆")]
