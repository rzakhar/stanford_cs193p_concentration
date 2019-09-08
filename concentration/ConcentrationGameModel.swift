//
//  ConcentrationGameModel.swift
//  concentration
//
//  Created by Roman Zakharov on 08/09/2019.
//  Copyright © 2019 Роман Захаров. All rights reserved.
//

import Foundation

class ConcentrationGameModel {
    
    var cards = [Card]()
    
    var timeStarted = Date.timeIntervalSinceReferenceDate
    
    var score = 0
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    let timeNow = Date.timeIntervalSinceReferenceDate
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 100 / Int(timeNow - timeStarted + 1)
                }
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or two cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                indexOfOneAndOnlyFaceUpCard = index
            }
            cards[index].isFaceUp = true
            if cards[index].wasPickedBefore {
                score -= 1
            }
            cards[index].wasPickedBefore = true
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
}
