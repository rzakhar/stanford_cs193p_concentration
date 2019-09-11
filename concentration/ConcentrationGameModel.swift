//
//  ConcentrationGameModel.swift
//  concentration
//
//  Created by Roman Zakharov on 08/09/2019.
//  Copyright © 2019 Роман Захаров. All rights reserved.
//

import Foundation

struct ConcentrationGameModel {
    
    private(set) var cards = [Card]()
    
    private var timeStarted = Date.timeIntervalSinceReferenceDate
    
    private(set) var score = 0
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter {cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index),
               "Concentration.chooseCard(at: \(index): Chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    let timeNow = Date.timeIntervalSinceReferenceDate
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 100 / Int(timeNow - timeStarted + 1)
                }
                cards[index].isFaceUp = true
            } else {
                // either no cards or two cards are face up
                indexOfOneAndOnlyFaceUpCard = index
            }
            if cards[index].wasPickedBefore {
                score -= 1
            }
            cards[index].wasPickedBefore = true
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0,
               "Concentration.init(\(numberOfPairsOfCards): Not positive number of pairs")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
}
